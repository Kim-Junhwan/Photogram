//
//  SearchViewController.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/28.
//

import UIKit


enum NetworkError: Error {
    case url
    case network(error: Error?)
    case decode(error: Error?)
}

protocol SearchViewControllerDelegate: AnyObject {
    func searchImage(imagePath: String)
}

class SearchViewController: BaseViewController {
    
    let searchView = SearchView()
    var searchedImagePathList: ImageList = ImageList(imageList: [])
    weak var delegate: SearchViewControllerDelegate?
    
    override func loadView() {
        view = searchView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configureView() {
        super.configureView()
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.searchBar.delegate = self
    }
    
    func searchImage(searchKeyword: String, completion: @escaping (Result<ImageList, Error>) -> Void) {
        let request = URLRequest(url: URL(string: "https://api.unsplash.com/search/photos?query=\(searchKeyword)&client_id=\(APIKey.unsplash)")!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                completion(.failure(NetworkError.network(error: error)))
                return
            }
            guard let data else { return }
            do {
                let decodeData = try JSONDecoder().decode(ImageList.self, from: data)
                completion(.success(decodeData))
            } catch let decodeError {
                print(NetworkError.network(error: decodeError))
            }
        }.resume()
    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchedImagePathList.imageList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AddCollectionViewCell", for: indexPath) as! SearchListCollectionViewCell
        cell.imageView.fetchImage(url: searchedImagePathList.imageList[indexPath.row].imageUrls.small)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.searchImage(imagePath: searchedImagePathList.imageList[indexPath.row].imageUrls.small)
        dismiss(animated: true)
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchImage(searchKeyword: searchBar.text!) { result in
            switch result {
            case .success(let imageList):
                self.searchedImagePathList = imageList
                DispatchQueue.main.async {
                    self.searchView.collectionView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//
//  SearchViewController.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/28.
//

import UIKit
import SnapKit

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
    var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, ImageInfo>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cellRegistration = .init(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            DispatchQueue.global().async {
                let url = URL(string: itemIdentifier.imageUrls.thumb)!
                let data = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    content.image = UIImage(data: data!)
                    cell.contentConfiguration = content
                }
            }
        })
    }
    
    override func configureView() {
        super.configureView()
        searchView.collectionView.delegate = self
        searchView.collectionView.dataSource = self
        searchView.searchBar.delegate = self
        view.addSubview(searchView)
    }
    
    override func setConstraints() {
        searchView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func searchImage(searchKeyword: String, completion: @escaping (Result<ImageList, Error>) -> Void) {
        guard let url = URL(string: "https://api.unsplash.com/search/photos?query=\(searchKeyword)&client_id=\(APIKey.unsplash)") else { return }
        let request = URLRequest(url: url, timeoutInterval: 10)
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
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: searchedImagePathList.imageList[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.searchImage(imagePath: searchedImagePathList.imageList[indexPath.row].imageUrls.regular)
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

extension SearchViewController: URLSessionDataDelegate {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        if let response = response as? HTTPURLResponse, (200...500).contains(response.statusCode) {
            return .allow
        } else {
            return .cancel
        }
    }
}

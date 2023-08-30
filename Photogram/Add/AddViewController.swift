//
//  ViewController.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/28.
//

import UIKit
import SnapKit
import PhotosUI

class AddViewController: BaseViewController {

    let mainView = AddView()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func setImage(notificationCenter: NSNotification) {
    }
    
    @objc func searchButtonClicked() {
        let alert = UIAlertController(title: "어떤 작업을 수행하시겠습니까?", message: "작업을 선택하십시오", preferredStyle: .actionSheet)
        let gallery = UIAlertAction(title: "갤러리에서 가져오기", style: .default, handler: showGallery(_:))
        let web = UIAlertAction(title: "웹에서 검색하기", style: .default, handler: showSearchView(_:))
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(gallery)
        alert.addAction(web)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func showGallery (_ : UIAlertAction) {
        var config = PHPickerConfiguration()
        config.selectionLimit = 1
        config.filter = .images
        let imagePicker = PHPickerViewController(configuration: config)
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    private func showSearchView(_ : UIAlertAction) {
        let searchViewController = SearchViewController()
        searchViewController.delegate = self
        present(searchViewController, animated: true)
    }
    
    
    override func configureView() {
        super.configureView()
        mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }

}

extension AddViewController: PHPickerViewControllerDelegate {
    
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        guard let itemProvider = results.first?.itemProvider else { return }
        displayImage(itemProvider: itemProvider)
    }
    
    private func displayImage(itemProvider: NSItemProvider) {
        if itemProvider.canLoadObject(ofClass: UIImage.self) {
            itemProvider.loadObject(ofClass: UIImage.self) { [weak self] image, error in
                guard let image = image as? UIImage else { return }
                DispatchQueue.main.async {
                    self?.mainView.photoImageView.image = image
                }
            }
        }
    }
    
}

extension AddViewController: SearchViewControllerDelegate {
    func searchImage(imagePath: String) {
        mainView.photoImageView.fetchImage(url: imagePath)
    }
}

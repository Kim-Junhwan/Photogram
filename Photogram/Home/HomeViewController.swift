//
//  HomeViewController.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/31.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class HomeViewController: BaseViewController {
    
    lazy var tableView: UITableView = {
       let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var addTabBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(tapAddButton))
        button.tintColor = .blue
        return button
    }()
    
    var fetchList: Results<DiaryTable>!
    let realm = try! Realm()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchList = realm.objects(DiaryTable.self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = addTabBarButton
    }
    
    override func setConstraints() {
        super.setConstraints()
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func tapAddButton() {
        let addVC = AddViewController()
        navigationController?.pushViewController(addVC, animated: true)
    }
    
    func loadImageFromDocument(fileName: String) -> UIImage {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return UIImage(systemName: "xmark")! }
        // 경로 설정(세부 경로, 이미지가 저장되어 있는 위치)
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        // 이미지 경로 여부 확인
        if FileManager.default.fileExists(atPath: fileURL.path()) {
            return UIImage(contentsOfFile: fileURL.path)!
        } else {
            return UIImage(systemName: "star.fill")!
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let data = fetchList[indexPath.row]
        var content = cell.defaultContentConfiguration()
        content.imageProperties.maximumSize = .init(width: 100, height: 100)
        content.text = data.diaryTitle
        if data.hasImage {
            content.image = loadImageFromDocument(fileName: "\(data._id).jpg")
        }
        cell.contentConfiguration = content
        return cell
    }
    
    
}

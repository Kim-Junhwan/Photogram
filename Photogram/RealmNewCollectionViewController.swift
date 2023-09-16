//
//  RealmNewCollectionViewController.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/09/14.
//

import Foundation
import UIKit
import SnapKit
import RealmSwift

class TodoTable: Object {
    @Persisted var todo: String
}

class RealmNewCollectionViewController: BaseViewController {
    
    let realm = try! Realm()
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout())
    var cellRegisteration: UICollectionView.CellRegistration<UICollectionViewCell, TodoTable>!
    var list: Results<TodoTable>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        cellRegisteration = .init(handler: { cell, indexPath, itemIdentifier in
            var content = UIListContentConfiguration.valueCell()
            content.text = itemIdentifier.todo
            content.secondaryText = "TEST"
            content.image = UIImage(systemName: "pencil")
            cell.contentConfiguration = content
        })
        collectionView.selectItem(at: [0,0], animated: true, scrollPosition: .init())
        list = realm.objects(TodoTable.self)
    }
    
    static func layout() -> UICollectionViewLayout {
        let config = UICollectionLayoutListConfiguration(appearance: .grouped)
        let layout = UICollectionViewCompositionalLayout.list(using: config)
        return layout
    }
}

extension RealmNewCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = list[indexPath.row]
        let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegisteration, for: indexPath, item: data)
        
        return cell
    }
    
    
}

//
//  SearchView.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/28.
//

import Foundation
import UIKit

class SearchView: BaseView {
    
    let searchBar: UISearchBar = {
       let view = UISearchBar()
        view.placeholder = "검색어"
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
        collectionView.register(SearchListCollectionViewCell.self, forCellWithReuseIdentifier: "AddCollectionViewCell")
        collectionView.keyboardDismissMode = .onDrag
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func configureView() {
        super.configureView()
        addSubview(searchBar)
        addSubview(collectionView)
        collectionViewLayout()
    }
    
    override func setConstraints() {
        super.setConstraints()
        searchBar.snp.makeConstraints { make in
            make.top.horizontalEdges.equalToSuperview()
        }
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp_bottomMargin)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    func collectionViewLayout() {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        collectionView.collectionViewLayout = layout
    }
}

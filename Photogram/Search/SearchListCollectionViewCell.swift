//
//  AddCollectionViewCell.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/28.
//

import Foundation
import UIKit

class SearchListCollectionViewCell: BaseCollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    override func configureView() {
        contentView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFill
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

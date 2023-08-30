//
//  AddView.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/28.
//

import Foundation
import UIKit

class AddView: BaseView {
    let photoImageView: UIImageView = {
       let view = UIImageView()
        view.backgroundColor = .lightGray
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        return view
    }()
    
    let searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        return button
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
    }
}

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
        button.tintColor = .red
        button.setImage(UIImage(systemName: "plus"), for: .normal)
        return button
    }()
    
    let titleTextField: UITextField = {
       let textField = UITextField()
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 2.0
        textField.placeholder = "제목을 입력하세요"
        return textField
    }()
    
    override func configureView() {
        addSubview(photoImageView)
        addSubview(searchButton)
        addSubview(titleTextField)
    }
    
    override func setConstraints() {
        photoImageView.snp.makeConstraints { make in
            make.topMargin.leadingMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
            make.height.equalTo(self).multipliedBy(0.3)
        }
        
        titleTextField.snp.makeConstraints { make in
            make.top.equalTo(photoImageView.snp_bottomMargin).offset(20)
            make.leadingMargin.trailingMargin.equalTo(safeAreaLayoutGuide).inset(10)
        }
        
        searchButton.snp.makeConstraints { make in
            make.size.equalTo(50)
            make.bottom.trailing.equalTo(photoImageView)
        }
    }
}

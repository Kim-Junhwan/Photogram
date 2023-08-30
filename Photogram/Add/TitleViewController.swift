//
//  TitleViewController.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/29.
//

import UIKit

class TitleViewController: BaseViewController {

    let textField: UITextField = {
       let view = UITextField()
        view.placeholder = "제목을 입력해주세요"
        return view
    }()
    
    override func configureView() {
        super.configureView()
        view.addSubview(textField)
        
    }
    
    override func setConstraints() {
        textField.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(view).inset(10)
            make.height.equalTo(50)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

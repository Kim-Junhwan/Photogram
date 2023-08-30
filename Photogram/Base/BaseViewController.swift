//
//  BaseViewController.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/28.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        setConstraints()
    }
    
    func configureView() {
        view.backgroundColor = .systemBackground
    }
    
    func setConstraints() {
        
    }

}

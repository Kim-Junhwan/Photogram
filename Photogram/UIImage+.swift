//
//  UIImage+.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/30.
//

import Foundation
import UIKit

extension UIImageView {
    func fetchImage(url: String) {
        guard let url = URL(string: url) else { return }
         let request = URLRequest(url: url) 
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
                return
            }
            guard let data else { return }
            DispatchQueue.main.async {
                self.image = UIImage(data: data)
            }
        }.resume()
    }
}

//
//  ImageList.swift
//  Photogram
//
//  Created by JunHwan Kim on 2023/08/30.
//

import Foundation

struct ImageList: Decodable {
    let imageList: [ImageInfo]
    
    enum CodingKeys: String, CodingKey {
        case imageList = "results"
    }
}

struct ImageInfo: Decodable {
    let imageUrls: ImagePath
    
    enum CodingKeys: String, CodingKey {
        case imageUrls = "urls"
    }
}

struct ImagePath: Decodable {
    let raw: String
    let full: String
    let regular: String
    let small: String
    let thumb: String
    let small_s3: String
}

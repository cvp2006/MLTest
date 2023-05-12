//
//  PicturesBodyResultProducts.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import Foundation

struct PicturesBodyResultProducts: Codable {
    let id: String?
    let url: String?
    let secureUrl: String?
    let size: String?
    let maxSize: String?
    let quality: String?
    
    enum CodingKeys: String, CodingKey {
        case secureUrl = "secure_url"
        case maxSize = "max_size"
        case id, url, size, quality
    }
}

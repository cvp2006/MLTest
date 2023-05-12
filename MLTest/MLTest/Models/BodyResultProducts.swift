//
//  BodyResultProducts.swift
//  MLTest
//
//  Created by Carlos Velasquez on 10/05/23.
//

import Foundation

struct BodyResultProducts: Codable {
    let id: String?
    let currencyId : String?
    let price: Double?
    let title: String?
    let permalink: String?
    let thumbnailId: String?
    let pictures: [PicturesBodyResultProducts]?
    let attributes: [AttributesBodyResultProducts]
    
    enum CodingKeys: String, CodingKey {
        case thumbnailId = "thumbnail_id"
        case currencyId = "currency_id"
        case id, price, title, permalink, attributes, pictures
    }
}

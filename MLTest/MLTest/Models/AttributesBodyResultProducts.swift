//
//  AttributesBodyResultProducts.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import Foundation

struct AttributesBodyResultProducts: Codable {
    let id: String?
    let name: String?
    let valueId: String?
    let valueName: String?
    
    enum CodingKeys: String, CodingKey {
        case valueId = "value_id"
        case valueName = "value_name"
        case id, name
    }
}

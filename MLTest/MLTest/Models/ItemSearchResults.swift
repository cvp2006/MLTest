//
//  SearchResults.swift
//  MLTest
//
//  Created by Carlos Velasquez on 23/04/23.
//

import Foundation

typealias Results = [ItemSearchResults]

// MARK: - ItemSearchResults
struct ItemSearchResults: Codable {
    let id, title, condition, thumbnailId : String
    let catalogProductId : String?
    let listingTypeId, permalink : String
    let buyingMode, categoryId, domainId, thumbnail, currencyId : String
    let price: Double
    let orderBackend, availableQuantity: Int
    
    enum CodingKeys: String, CodingKey {
        case id, title, condition, permalink, thumbnail
        case price
        case thumbnailId = "thumbnail_id"
        case catalogProductId = "catalog_product_id"
        case listingTypeId = "listing_type_id"
        case buyingMode = "buying_mode"
        case categoryId = "category_id"
        case domainId = "domain_id"
        case currencyId = "currency_id"
        case orderBackend = "order_backend"
        case availableQuantity = "available_quantity"
    }
}

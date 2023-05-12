//
//  SearchData.swift
//  MLTest
//
//  Created by Carlos Velasquez on 23/04/23.
//

import Foundation

// MARK: - SearchData
struct SearchData: Codable {
    let query: String?
    var status: Int?
    let results: Results?
    let availableFilters: AvailableFilters?
    let paging: Paging?
    
    enum CodingKeys: String, CodingKey {
        case availableFilters = "available_filters"
        case query, results, paging, status
    }
}

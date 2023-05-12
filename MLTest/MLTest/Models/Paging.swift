//
//  Paging.swift
//  MLTest
//
//  Created by Carlos Velasquez on 26/04/23.
//

import Foundation

// MARK: - SearchData
struct Paging: Codable {
    let total, primaryResults, offset, limit: Int

    enum CodingKeys: String, CodingKey {
        case primaryResults = "primary_results"
        case total, offset, limit
    }
}

extension Paging {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.total = try container.decode(Int.self, forKey: .total )
        self.primaryResults = try container.decode(Int.self, forKey: .primaryResults )
        self.offset = try container.decode(Int.self, forKey: .offset )
        self.limit = try container.decode(Int.self, forKey: .limit )
        
    }
}

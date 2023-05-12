//
//  ValuesFilter.swift
//  MLTest
//
//  Created by Carlos Velasquez on 25/04/23.
//

import Foundation

typealias ValuesFilters = [ValuesFilter]

struct ValuesFilter: Codable {
    let id, name : String
    let results : Int
}

extension ValuesFilter {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        self.name = try container.decode(String.self, forKey: .name)
        self.results = try container.decode(Int.self, forKey: .results)
    }
}

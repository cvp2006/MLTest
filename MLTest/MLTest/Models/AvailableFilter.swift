//
//  AvailableFilters.swift
//  MLTest
//
//  Created by Carlos Velasquez on 25/04/23.
//

import Foundation

typealias AvailableFilters = [AvailableFilter]

struct AvailableFilter: Codable {
    let id, name, type : String
    let values: ValuesFilters
    
}

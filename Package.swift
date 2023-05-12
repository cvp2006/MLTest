//
//  Package.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import PackageDescription

let package = Package(
  name: "MLTest",
  dependencies: [
    .Package(url: "https://git.heroku.com/mltest-cvp.git", majorVersion: 0, minor: 6),
  ]
)
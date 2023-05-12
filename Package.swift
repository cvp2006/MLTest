//
//  Package.swift
//  MLTest
//
//  Created by Carlos Velasquez on 11/05/23.
//

import PackageDescription

let package = Package(
  name: "HelloWorld",
  dependencies: [
    .Package(url: "https://github.com/kylef/Curassow.git", majorVersion: 0, minor: 6),
  ]
)
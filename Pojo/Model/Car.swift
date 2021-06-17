//
//  Car.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import Foundation

struct Car: Decodable {
  let make: String
  let model: String
  let year: Int
  let picture: String
  let equipments: [String]?
  var keywords: String {
    var words = make + " " + model + " \(year) "
    if let equipments = equipments {
      words += equipments.joined(separator: " ")
    }
    return words.lowercased()
  }
}

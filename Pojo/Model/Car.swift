//
//  RealCar.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import Foundation
import RealmSwift

protocol Car {
  var make: String { get }
  var model: String { get }
  var year: Int { get }
  var picture: String { get }
  var equipments: [String]? { get }
  var keywords: String { get }
}

struct Free2MoveCar: Decodable, Car {
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

final class CarObject: Object, Car {
  @objc dynamic var make = ""
  @objc dynamic var model = ""
  @objc dynamic var year = 1900
  @objc dynamic var picture = ""
  @objc dynamic var keywords = ""
  var equipments: [String]? { equipments_.sorted() }
  private let equipments_ = List<String>()
  
  override static func primaryKey() -> String? {
    return "keywords"
  }
  
  convenience init(car: Car) {
    self.init()
    make = car.make
    model = car.model
    year = car.year
    picture = car.picture
    car.equipments?.forEach(equipments_.append)
    keywords = car.keywords
  }
}

//
//  CarViewModel.swift
//  Pojo
//
//  Created by Kien on 18/06/2021.
//

import Foundation

struct CarViewModel {
  let car: Car
  
  var imageURL: URL? { URL(string: car.picture) }
  var subtitle: String { "\(car.year)" }
  var title: String { car.make + " " + car.model }
  var body: String {
    return car.equipments?.joined(separator: ", ") ?? ""
  }
}

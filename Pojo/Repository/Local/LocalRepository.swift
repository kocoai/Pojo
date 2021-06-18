//
//  LocalRepository.swift
//  Pojo
//
//  Created by Kien on 18/06/2021.
//

import Foundation
import RealmSwift

struct LocalRepository: Repository {
  func fetch(keywords: String, completion: CarCompletion?) {
    let realm = try? Realm()
    guard let result = realm?.objects(CarObject.self).filter("keywords contains %@", keywords) else {
      return
    }
    completion?(.success(Array(result)))
  }
  
  func save(cars: [Car]) {
    let realm = try? Realm()
    try? realm?.write {
      cars.map(CarObject.init).forEach { carObject in
        realm?.add(carObject, update: .all)
      }
    }
  }
}

//
//  LocalRepositoryMock.swift
//  PojoTests
//
//  Created by Kien on 21/06/2021.
//

import Foundation
@testable import Pojo

final class LocalRepositoryMock: Repository {
  var cars: [Car]?
  var isSuccess = true
  var fetchGetCalled: ((String) -> Void)?
  var saveGetCalled: (([Car]) -> Void)?
  
  func fetch(keywords: String, completion: CarCompletion?) {
    fetchGetCalled?(keywords)
    guard isSuccess, let cars = cars else {
      completion?(.failure(ErrorMock.dummyFailure))
      return
    }
    completion?(.success(cars))
  }
  
  func save(cars: [Car]) {
    saveGetCalled?(cars)
  }
}

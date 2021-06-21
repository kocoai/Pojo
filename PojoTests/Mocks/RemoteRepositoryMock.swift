//
//  RemoteRepositoryMock.swift
//  PojoTests
//
//  Created by Kien on 21/06/2021.
//

import Foundation
@testable import Pojo

final class RemoteRepositoryMock: Repository {
  var isSuccess = true
  var cars: [Car]!
  var fetchGetCalled: ((String) -> Void)?
  
  func fetch(keywords: String, completion: CarCompletion?) {
    fetchGetCalled?(keywords)
    guard isSuccess else {
      completion?(.failure(ErrorMock.dummyFailure))
      return
    }
    completion?(.success(cars))
  }
  
  func save(cars: [Car]) {}
}

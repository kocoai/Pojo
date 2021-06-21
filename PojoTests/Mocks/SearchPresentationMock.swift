//
//  SearchPresentationMock.swift
//  PojoTests
//
//  Created by Kien on 21/06/2021.
//

import Foundation
@testable import Pojo

final class SearchPresentationMock: SearchPresentationLogic {
  var presentGetCalled: (([Car], String) -> Void)?
  
  func present(cars: [Car], keywords: String) {
    presentGetCalled?(cars, keywords)
  }
}

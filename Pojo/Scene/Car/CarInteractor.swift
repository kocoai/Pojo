//
//  CarInteractor.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import Foundation

protocol CarBusinessLogic {
  func load()
}

protocol CarDataStore {
  var car: Car? { get set }
}

final class CarInteractor: CarBusinessLogic, CarDataStore {
  var car: Car?
  private var presenter: CarPresentationLogic
  
  init(presenter: CarPresentationLogic) {
    self.presenter = presenter
  }
  
  func load() {
    if let car = car {
      presenter.present(car: car)
    }
  }
}

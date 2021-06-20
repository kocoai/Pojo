//
//  CarPresenter.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import Foundation

protocol CarPresentationLogic {
  func present(car: Car)
}

final class CarPresenter: CarPresentationLogic {
  private weak var display: CarDisplayLogic?
  
  init(display: CarDisplayLogic) {
    self.display = display
  }
  
  func present(car: Car) {
    display?.display(viewModel: CarViewModel(car: car))
  }
}

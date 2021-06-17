//
//  SearchPresenter.swift
//  Pojo
//
//  Created by Kien on 18/06/2021.
//

import Foundation

protocol SearchPresentationLogic {
  func present(cars: [Car], keywords: String)
}

struct SearchPresenter: SearchPresentationLogic {
  let display: SearchDisplayLogic
  
  init(display: SearchDisplayLogic) {
    self.display = display
  }

  func present(cars: [Car], keywords: String) {
    let viewModel = SearchViewModel(cars: cars, keywords: keywords)
    DispatchQueue.main.async {
      display.display(viewModel: viewModel)
    }
  }
  
}

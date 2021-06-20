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

final class SearchPresenter: SearchPresentationLogic {
  private weak var display: SearchDisplayLogic?
  
  init(display: SearchDisplayLogic) {
    self.display = display
  }

  func present(cars: [Car], keywords: String) {
    let viewModel = SearchViewModel(cars: cars, keywords: keywords)
    DispatchQueue.main.async {
      self.display?.display(viewModel: viewModel)
    }
  }
  
}

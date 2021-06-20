//
//  AccountPresenter.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import Foundation

protocol AccountPresentationLogic {
  func present(user: User)
}

final class AccountPresenter: AccountPresentationLogic {
  private weak var display: AccountDisplayLogic?
  
  init(display: AccountDisplayLogic) {
    self.display = display
  }
  
  func present(user: User) {
    display?.display(viewModel: AccountViewModel(user: user))
  }
}

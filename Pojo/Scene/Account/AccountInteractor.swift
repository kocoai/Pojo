//
//  AccountInteractor.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import Foundation

protocol AccountBusinessLogic {
  func load()
  func save(user: User)
}
struct AccountInteractor: AccountBusinessLogic {
  private let presenter: AccountPresentationLogic
  
  init(presenter: AccountPresentationLogic) {
    self.presenter = presenter
  }
  
  func save(user: User) {
    UserDefaults.standard.userLastName = user.lastName
    UserDefaults.standard.userFirstName =  user.firstName
    UserDefaults.standard.userAddress = user.address
    UserDefaults.standard.userBirthDate = user.birthDate
    UserDefaults.standard.userPhoto = user.photo
  }
  
  func load() {
    let user = User(firstName: UserDefaults.standard.userFirstName, lastName: UserDefaults.standard.userLastName, address: UserDefaults.standard.userAddress, birthDate: UserDefaults.standard.userBirthDate, photo: UserDefaults.standard.userPhoto)
    presenter.present(user: user)
  }
}

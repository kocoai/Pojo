//
//  AccountViewModel.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import UIKit

struct AccountViewModel {
  var userFirstName: String?
  var userLastName: String?
  var userAddress: String?
  var userBirthDate: Date?
  var userPhoto: UIImage?
  
  init(user: User) {
    userFirstName = user.firstName
    userLastName = user.lastName
    userAddress = user.address
    userBirthDate = user.birthDate
    userPhoto = user.photo
  }
}

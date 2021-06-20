//
//  UserDefaults+Settings.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import Foundation
import UIKit

extension UserDefaults {
  enum Keys {
    static let userFirstName = "userFirstName"
    static let userLastName = "userLastName"
    static let userAddress = "userAddress"
    static let userBirthDate = "userBirthDate"
    static let userPhoto = "userPhoto"
  }
  
  var userFirstName: String? {
    get { string(forKey: Keys.userFirstName )}
    set { setValue(newValue, forKey: Keys.userFirstName)}
  }
  
  var userLastName: String? {
    get { string(forKey: Keys.userLastName )}
    set { setValue(newValue, forKey: Keys.userLastName)}
  }
  
  var userAddress: String? {
    get { string(forKey: Keys.userAddress )}
    set { setValue(newValue, forKey: Keys.userAddress)}
  }
  
  var userBirthDate: Date? {
    get { object(forKey: Keys.userBirthDate) as? Date }
    set { setValue(newValue, forKey: Keys.userBirthDate)}
  }
  
  var userPhoto: UIImage? {
    get {
      guard let imageData = object(forKey: Keys.userPhoto) as? Data,
            let image = UIImage(data: imageData) else {
        return nil
      }
      return image
    }
    set { setValue(newValue?.pngData(), forKey: Keys.userPhoto) }
  }
}

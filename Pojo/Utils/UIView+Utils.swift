//
//  UIView+Transformation.swift
//  Pojo
//
//  Created by Kien on 20/06/2021.
//

import UIKit

extension UIView {
  @discardableResult
  func circle() -> UIView {
    clipsToBounds = true
    layer.cornerRadius = frame.width/2
    return self
  }
  
  @discardableResult
  func shadow() -> UIView {
    layer.masksToBounds = false
    layer.shadowRadius = 10
    layer.shadowOpacity = 0.3
    return self
  }
}

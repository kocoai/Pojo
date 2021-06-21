//
//  String+Utils.swift
//  Pojo
//
//  Created by Kien on 21/06/2021.
//

import Foundation

extension String {
  var trimmed: String {
    trimmingCharacters(in: .whitespacesAndNewlines)
  }
}

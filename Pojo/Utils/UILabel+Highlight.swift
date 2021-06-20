//
//  UILabel+Highlight.swift
//  Pojo
//
//  Created by Kien on 18/06/2021.
//

import UIKit

extension UILabel {
  /**
   Highlight text in a label. https://leocardz.com/2018/09/26/uilabel-search-highlighter
   - parameter value: The full text.
   - parameter highlight: The text to be highlighted.
   */
  func setText(value: String?, highlight: String?) {
    guard let value = value, let highlight = highlight else { return }
    let attributedText = NSMutableAttributedString(string: value)
    let range = (value as NSString).range(of: highlight, options: .caseInsensitive)
    let strokeTextAttributes: [NSAttributedString.Key: Any] = [
      .backgroundColor: UIColor.systemYellow,
      .foregroundColor: UIColor.black
    ]
    attributedText.addAttributes(strokeTextAttributes, range: range)
    self.attributedText = attributedText
  }
}

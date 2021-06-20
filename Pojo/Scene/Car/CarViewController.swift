//
//  CarViewController.swift
//  Pojo
//
//  Created by Kien on 18/06/2021.
//

import UIKit
import Kingfisher

protocol CarDisplayLogic: AnyObject {
  func display(viewModel: CarViewModel)
}

final class CarViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var bodyLabel: UILabel!
  var viewModel: CarViewModel?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let viewModel = viewModel {
      display(viewModel: viewModel)
    }
  }
}

extension CarViewController: CarDisplayLogic {
  func display(viewModel: CarViewModel) {
    subtitleLabel.text = viewModel.subtitle
    titleLabel.text = viewModel.title
    bodyLabel.text = viewModel.body
    imageView.kf.setImage(with: viewModel.imageURL, placeholder: UIImage(systemName: "car"))
  }
}


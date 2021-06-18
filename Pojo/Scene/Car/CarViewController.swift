//
//  CarViewController.swift
//  Pojo
//
//  Created by Kien on 18/06/2021.
//

import UIKit
import Kingfisher

final class CarViewController: UIViewController {
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var subtitleLabel: UILabel!
  @IBOutlet var titleLabel: UILabel!
  @IBOutlet var bodyLabel: UILabel!
  var viewModel: CarViewModel?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    subtitleLabel.text = viewModel?.subtitle
    titleLabel.text = viewModel?.title
    bodyLabel.text = viewModel?.body
    imageView.kf.setImage(with: viewModel?.imageURL)
  }
}

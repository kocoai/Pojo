//
//  SearchViewController.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import UIKit

final class SearchViewController: UIViewController {
  override func viewDidLoad() {
    super.viewDidLoad()
    let remoteRepo = RemoteRepository()
    remoteRepo.fetch(keywords: "") { result in
      
    }
  }
}


//
//  RemoteRepository.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import Foundation

struct RemoteRepository: Repository {
  let webService: WebService
  
  init(webService: WebService = WebService()) {
    self.webService = webService
  }
  
  func fetch(keywords: String, completion: CarCompletion?) {
    webService.fetch { result in
      switch result {
      case .success(let cars):
        cars.forEach { car in
          print(car.keywords)
        }
      case .failure( let error):
        print(error)
      }
    }
  }
}

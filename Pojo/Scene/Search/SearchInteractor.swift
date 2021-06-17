//
//  SearchInteractor.swift
//  Pojo
//
//  Created by Kien on 18/06/2021.
//

import Foundation

protocol SearchBusinessLogic {
  func search(keywords: String)
}

protocol SearchDataStore {
  var data: [Car] { get  }
}

final class SearchInteractor: SearchBusinessLogic, SearchDataStore {
  var data = [Car]()
  let remoteRepo: RemoteRepository
  let prensenter: SearchPresentationLogic
  
  init(prensenter: SearchPresentationLogic, remoteRepo: RemoteRepository = RemoteRepository()) {
    self.prensenter = prensenter
    self.remoteRepo = remoteRepo
  }
  
  func search(keywords: String) {
    remoteRepo.fetch(keywords: keywords) { [weak self] result in
      switch result{
      case .success(let cars):
        self?.data = cars
        self?.prensenter.present(cars: cars, keywords: keywords)
      case .failure(_):
        self?.data = []
        self?.prensenter.present(cars: [], keywords: keywords)
      }
    }
  }
}

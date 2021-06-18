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
  private let remote: Repository
  private let local: Repository
  private let prensenter: SearchPresentationLogic
  
  init(prensenter: SearchPresentationLogic, remote: Repository = RemoteRepository(), local: Repository = LocalRepository()) {
    self.prensenter = prensenter
    self.remote = remote
    self.local = local
  }
  
  func search(keywords: String) {
    remote.fetch(keywords: keywords) { [weak self] result in
      switch result{
      case .success(let cars):
        self?.data = cars
        self?.prensenter.present(cars: cars, keywords: keywords)
        self?.local.save(cars: cars)
      case .failure(_):
        self?.searchFromCache(keywords: keywords)
      }
    }
  }
  
  private func searchFromCache(keywords: String) {
    local.fetch(keywords: keywords) { [weak self] result in
      switch result {
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

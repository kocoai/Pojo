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
  var cars: [Car] { get }
}

final class SearchInteractor: SearchBusinessLogic, SearchDataStore {
  var cars = [Car]()
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
        self?.cars = cars
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
        self?.cars = cars
        self?.prensenter.present(cars: cars, keywords: keywords)
      case .failure(_):
        self?.cars = []
        self?.prensenter.present(cars: [], keywords: keywords)
      }
    }
  }
}

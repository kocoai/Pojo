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
  private let mainRepo: Repository
  private let backupRepo: Repository
  private let prensenter: SearchPresentationLogic
  
  init(prensenter: SearchPresentationLogic, remote: Repository = RemoteRepository(), local: Repository = LocalRepository()) {
    self.prensenter = prensenter
    self.mainRepo = remote
    self.backupRepo = local
  }
  
  func search(keywords: String) {
    mainRepo.fetch(keywords: keywords) { [weak self] result in
      switch result{
      case .success(let cars):
        self?.cars = cars
        self?.prensenter.present(cars: cars, keywords: keywords)
        self?.backupRepo.save(cars: cars)
      case .failure(_):
        self?.searchFromBackup(keywords: keywords)
      }
    }
  }
  
  private func searchFromBackup(keywords: String) {
    backupRepo.fetch(keywords: keywords) { [weak self] result in
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

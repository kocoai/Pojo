//
//  WebService.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import Foundation

struct WebService {
  private let url = "https://gist.githubusercontent.com/ncltg/6a74a0143a8202a5597ef3451bde0d5a/raw/8fa93591ad4c3415c9e666f888e549fb8f945eb7/tc-test-ios.json"
  
  func fetch(completion: CarCompletion?) {
    URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
      if let error = error {
        completion?(.failure(error))
        return
      }
      guard let data = data,
            let cars = try? JSONDecoder().decode([Free2MoveCar].self, from: data) else {
        completion?(.failure(PojoError.fetchRemoteFailure))
        return
      }
      completion?(.success(cars))
    }.resume()
  }
}

enum PojoError: Error {
  case fetchRemoteFailure
}

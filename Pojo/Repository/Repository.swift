//
//  Repository.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import Foundation

typealias CarCompletion = (Result<[Car], Error>) -> Void

protocol Repository {
  func fetch(keywords: String, completion: CarCompletion?)
  func save(cars: [Car])
}

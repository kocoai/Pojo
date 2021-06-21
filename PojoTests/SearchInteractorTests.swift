//
//  SearchInteractorTests.swift
//  PojoTests
//
//  Created by Kien on 17/06/2021.
//

import XCTest
@testable import Pojo

final class SearchInteractorTests: XCTestCase {
  private var interactor: SearchInteractor!
  private var remote: RemoteRepositoryMock!
  private var local: LocalRepositoryMock!
  private var presenter: SearchPresentationMock!
  private var dummyCars: [Car]!
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
    remote = RemoteRepositoryMock()
    local = LocalRepositoryMock()
    presenter = SearchPresentationMock()
    interactor = SearchInteractor(prensenter: presenter, remote: remote, local: local)
    dummyCars = Array(0...10).map { Free2MoveCar(make: "make \($0)", model: "model \($0)", year: 2000 + $0, picture: "https://image\($0).png", equipments: ["gps", "climatisation"]) }
  }
  
  func testSearchRemoteSuccess() throws {
    // context
    remote.cars = dummyCars
    local.cars = []
    
    // presenter must present cars returned by remote repo
    let expectPresentGetCalled = expectation(description: "expectPresentGetCalled")
    presenter.presentGetCalled = { cars, keywords in
      expectPresentGetCalled.fulfill()
      XCTAssertEqual(cars.count, self.remote.cars?.count)
      XCTAssertNotEqual(cars.count, self.local.cars?.count)
      for i in 0 ..< cars.count {
        XCTAssertEqual(cars[i].make, self.remote.cars?[i].make)
        XCTAssertEqual(cars[i].keywords, self.remote.cars?[i].keywords)
      }
      XCTAssertEqual(cars[4].make, "make 4")
      XCTAssertEqual(cars[4].year, 2004)
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    // remote repo must call fetch (get success)
    let expectRemoteFetchGetCalled = expectation(description: "expectRemoteFetchGetCalled")
    remote.fetchGetCalled = { keywords in
      expectRemoteFetchGetCalled.fulfill()
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    // local repo must save cars
    let expectLocalSaveGetCalled = expectation(description: "expectLocalSaveGetCalled")
    local.saveGetCalled = { cars in
      expectLocalSaveGetCalled.fulfill()
      XCTAssertEqual(cars.count, self.remote.cars?.count)
      XCTAssertEqual(cars.count, 11)
      for i in 0 ..< cars.count {
        XCTAssertEqual(cars[i].make, self.remote.cars?[i].make)
        XCTAssertEqual(cars[i].keywords, self.remote.cars?[i].keywords)
      }
      XCTAssertEqual(cars[3].model, "model 3")
      XCTAssertEqual(cars[3].year, 2003)
    }
    
    // local repo should not call fetch
    local.fetchGetCalled = { _ in
      XCTFail()
    }
    
    interactor.search(keywords: "dummy keywords")
    waitForExpectations(timeout: 2)
  }
  
  func testSearchRemoteFailure() throws {
    // context
    remote.isSuccess = false
    local.cars = dummyCars
    remote.cars = []
    
    // presenter must present cars returned by local repo
    let expectPresentGetCalled = expectation(description: "expectPresentGetCalled")
    presenter.presentGetCalled = { cars, keywords in
      expectPresentGetCalled.fulfill()
      XCTAssertEqual(cars.count, self.local.cars?.count)
      XCTAssertNotEqual(cars.count, self.remote.cars?.count)
      for i in 0..<cars.count {
        XCTAssertEqual(cars[i].make, self.local.cars?[i].make)
        XCTAssertEqual(cars[i].keywords, self.local.cars?[i].keywords)
      }
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    // remote repo must call fetch (get failure)
    let expectRemoteFetchGetCalled = expectation(description: "expectRemoteFetchGetCalled")
    remote.fetchGetCalled = { keywords in
      expectRemoteFetchGetCalled.fulfill()
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    // local repo should not call save
    local.saveGetCalled = { _ in
      XCTFail()
    }
    
    // local repo must call fetch (get success)
    let expectLocalFetchGetCalled = expectation(description: "expectLocalFetchGetCalled")
    local.fetchGetCalled = { keywords in
      expectLocalFetchGetCalled.fulfill()
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    interactor.search(keywords: "dummy keywords")
    waitForExpectations(timeout: 2)
  }
  
  func testSearchRemoteLocalFailure() throws {
    // context
    remote.isSuccess = false
    local.isSuccess = false
    local.cars = dummyCars
    remote.cars = []
    
    // presenter must present an empty cars list
    let expectPresentGetCalled = expectation(description: "expectPresentGetCalled")
    presenter.presentGetCalled = { cars, keywords in
      expectPresentGetCalled.fulfill()
      XCTAssertEqual(cars.count, 0)
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    // remote repo must call fetch (get failure)
    let expectRemoteFetchGetCalled = expectation(description: "expectRemoteFetchGetCalled")
    remote.fetchGetCalled = { keywords in
      expectRemoteFetchGetCalled.fulfill()
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    // local repo should not call save
    local.saveGetCalled = { _ in
      XCTFail()
    }
    
    // local repo must call fetch (get failure)
    let expectLocalFetchGetCalled = expectation(description: "expectLocalFetchGetCalled")
    local.fetchGetCalled = { keywords in
      expectLocalFetchGetCalled.fulfill()
      XCTAssertEqual(keywords, "dummy keywords")
    }
    
    interactor.search(keywords: "dummy keywords")
    waitForExpectations(timeout: 2)
  }
}

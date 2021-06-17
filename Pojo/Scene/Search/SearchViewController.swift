//
//  SearchViewController.swift
//  Pojo
//
//  Created by Kien on 17/06/2021.
//

import UIKit

protocol SearchDisplayLogic {
  func display(viewModel: SearchViewModel)
}

final class SearchViewController: UIViewController {
  @IBOutlet private var tableView: UITableView!
  @IBOutlet private var searchBar: UISearchBar!
  private var viewModel = SearchViewModel(cars: [], keywords: "")
  private var interactor: SearchBusinessLogic!

  override func viewDidLoad() {
    super.viewDidLoad()
    interactor = SearchInteractor(prensenter: SearchPresenter(display: self))
  }
  
  @objc func search() {
    guard let searchText = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines).lowercased(), !searchText.isEmpty else {
      viewModel = SearchViewModel(cars: [], keywords: "")
      tableView.reloadData()
      return
    }
    interactor.search(keywords: searchText)
  }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.cars.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "CarCell", for: indexPath)
    cell.textLabel?.setText(value: viewModel.cars[indexPath.row].keywords, highlight: viewModel.keywords)
    return cell
  }
}

extension SearchViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(search), object: nil)
    self.perform(#selector(search), with: nil, afterDelay: 0.5)
  }
}

extension SearchViewController: SearchDisplayLogic {
  func display(viewModel: SearchViewModel) {
    self.viewModel = viewModel
    tableView.reloadData()
  }
}

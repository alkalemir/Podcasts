//
//  SearchController.swift
//  Podcasts
//
//  Created by Emir Alkal on 29.04.2023.
//

import UIKit

final class SearchController: UITableViewController {
    
    let dummyPodcasts = [
        Podcast(name: "Test", artistName: "Another"),
        Podcast(name: "Test", artistName: "Another"),
        Podcast(name: "Test", artistName: "Another"),
        Podcast(name: "Test", artistName: "Another")
    ]
    
    private let cellId = "podcastCell"
    private let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        setupTableView()
    }
    
    private func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.delegate = self
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        dummyPodcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = "\(dummyPodcasts[indexPath.row].artistName)\n\(dummyPodcasts[indexPath.row].name)"
        return cell
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("clicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}

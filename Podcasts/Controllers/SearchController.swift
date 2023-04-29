//
//  SearchController.swift
//  Podcasts
//
//  Created by Emir Alkal on 29.04.2023.
//

import UIKit
import Alamofire

final class SearchController: UITableViewController {
    
    var podcasts: [Podcast] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
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
        podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.numberOfLines = 2
        cell.textLabel?.text = "\(podcasts[indexPath.row].artistName ?? "")\n\(podcasts[indexPath.row].trackName ?? "")"
        return cell
    }
}

extension SearchController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("clicked")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let parameters = ["term": searchText]
        
        AF.request("https://itunes.apple.com/search", parameters: parameters, encoding: URLEncoding.default).responseData { [weak self] response in
            guard let self else { return }
            guard response.error == nil else { return }
            guard let data = response.data else { return }
            
            do {
                let decodedObj = try JSONDecoder().decode(SearchResponse.self, from: data)
                self.podcasts = decodedObj.results
            } catch {
                print(error)
            }
        }
    }
}

//
//  EpisodesController.swift
//  Podcasts
//
//  Created by Emir Alkal on 1.05.2023.
//

import UIKit
import FeedKit

final class EpisodesController: UITableViewController {
    
    var podcast: Podcast! {
        didSet {
            navigationItem.title = podcast.trackName
            fetchEpisodes()
        }
    }

    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: EpisodeCell.cellID)
        tableView.rowHeight = 132
    }
    
    private func fetchEpisodes() {
        guard let feedString = podcast.feedUrl else { return }
        let secureFeedURL = feedString.toSecureHTTPS()
        guard let feedURL = URL(string: secureFeedURL) else { return }
        let parser = FeedParser(URL: feedURL)
        parser.parseAsync { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let feed):
                switch feed {
                case let .rss(feed):
                    let imageURL = feed.iTunes?.iTunesImage?.attributes?.href
                    
                    feed.items?.forEach({
                        var episode = Episode(feedItem: $0)
                        episode.imageURL = imageURL
                        self.episodes.append(episode)
                    })
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                default:
                    fatalError("feed error")
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: EpisodeCell.cellID, for: indexPath) as? EpisodeCell else { fatalError() }
        cell.episode = episodes[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let window = UIApplication.shared.keyWindow
        let playerDetailsView = Bundle.main.loadNibNamed("PlayerDetailView", owner: self)?.first as! PlayerDetailView
        playerDetailsView.episode = episodes[indexPath.row]
        
        playerDetailsView.frame = view.frame
        window?.addSubview(playerDetailsView)
    }
}

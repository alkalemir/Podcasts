//
//  PodcastCell.swift
//  Podcasts
//
//  Created by Emir Alkal on 1.05.2023.
//

import UIKit
import SDWebImage

final class PodcastCell: UITableViewCell {

    @IBOutlet weak var podcastImageView: UIImageView!
    @IBOutlet weak var trackNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var episodeCountLabel: UILabel!
    
    static let cellID = "PodcastCell"
    
    var podcast: Podcast! {
        didSet {
            trackNameLabel.text = podcast.trackName
            artistNameLabel.text = podcast.artistName
            episodeCountLabel.text = "\(podcast.trackCount ?? 0) Episodes"
            guard let url = URL(string: podcast.profileImage ?? "") else { return }
            podcastImageView.sd_setImage(with: url)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        podcastImageView.image = nil
        trackNameLabel.text = ""
        artistNameLabel.text = ""
        episodeCountLabel.text = ""
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        podcastImageView.layer.cornerRadius = 8
    }
}

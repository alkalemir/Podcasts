//
//  PlayerDetailView.swift
//  Podcasts
//
//  Created by Emir Alkal on 2.05.2023.
//

import UIKit

final class PlayerDetailView: UIView {
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            authorLabel.text = episode.author
            guard let url = URL(string: episode.imageURL ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    @IBAction func handleDismiss(sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func handlePlayButton(_ sender: UIButton) {
        
    }
    
    @IBAction func handleRewindButton(_ sender: UIButton) {
        
    }
    
    @IBAction func handleForwardButton(_ sender: UIButton) {
        
    }
}

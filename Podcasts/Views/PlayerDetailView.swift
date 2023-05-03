//
//  PlayerDetailView.swift
//  Podcasts
//
//  Created by Emir Alkal on 2.05.2023.
//

import UIKit
import AVKit

final class PlayerDetailView: UIView {
    
    @IBOutlet weak var episodeImageView: UIImageView! {
        didSet {
            episodeImageView.layer.cornerRadius = 5
            episodeImageView.clipsToBounds = true
            episodeImageView.transform = .init(scaleX: 0.7, y: 0.7)
        }
    }
    
    @IBOutlet weak var timeSlider: UISlider!
    @IBOutlet weak var passedTimeLabel: UILabel!
    @IBOutlet weak var totalTimeLabel: UILabel!
    @IBOutlet weak var episodeTitleLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton! {
        didSet {
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            playPauseButton.addTarget(self, action: #selector(handlePlayPause), for: .touchUpInside)
        }
    }
    
    
    
    var episode: Episode! {
        didSet {
            episodeTitleLabel.text = episode.title
            authorLabel.text = episode.author
            guard let url = URL(string: episode.imageURL ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
            playEpisode()
        }
    }
    
    private let player: AVPlayer = {
        let avPlayer = AVPlayer()
        avPlayer.automaticallyWaitsToMinimizeStalling = true
        return avPlayer
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let interval = CMTimeMake(value: 1, timescale: 2)
        player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self else { return }
            self.passedTimeLabel.text = time.toDisplayString()
            
            if let duration = self.player.currentItem?.duration {
                self.totalTimeLabel.text = duration.toDisplayString()
                let passed = Int(CMTimeGetSeconds(time))
                let total = Int(CMTimeGetSeconds(duration))
                self.timeSlider.value = Float(passed) / Float(total)
            }
        }
        
        let time = CMTimeMake(value: 1, timescale: 3)
        let times = [NSValue(time: time)]
        player.addBoundaryTimeObserver(forTimes: times, queue: .main) { [weak self] in
            guard let self else { return }
            self.enlargeEpisodeImageView()
        }
    }
    
    private func playEpisode() {
        guard let mediaUrl = URL(string: episode.mediaUrl ?? "") else { return }
        player.replaceCurrentItem(with: AVPlayerItem(url: mediaUrl))
        player.play()
    }
    
    @objc private func handlePlayPause() {
        if player.timeControlStatus == .paused {
            player.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            enlargeEpisodeImageView()
        } else {
            player.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            shrinkEpisodeImageView()
        }
    }
    
    private func enlargeEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseOut) {
            self.episodeImageView.transform = .identity
        }
    }
    
    private func shrinkEpisodeImageView() {
        UIView.animate(withDuration: 0.75, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseIn) {
            self.episodeImageView.transform = .init(scaleX: 0.7, y: 0.7)
        }
    }
    
    @IBAction func volumeSliderValueChanged(_ sender: UISlider) {
        player.volume = sender.value
    }
    
    @IBAction func timeSliderValueChanged(_ sender: UISlider) {
        let percentage = sender.value
        guard let duration = player.currentItem?.duration else { return }
        let durationInSeconds = CMTimeGetSeconds(duration)
        let seekTimeInSeconds = Float64(percentage) * durationInSeconds
        let seekTime = CMTimeMakeWithSeconds(seekTimeInSeconds, preferredTimescale: Int32(NSEC_PER_SEC))
        player.seek(to: seekTime)
    }
    
    @IBAction func handleDismiss(sender: UIButton) {
        self.removeFromSuperview()
    }
    
    @IBAction func handleRewindButton(_ sender: UIButton) {
        let seekTime = CMTimeSubtract(player.currentTime(), CMTimeMake(value: 15, timescale: 1))
        player.seek(to: seekTime)
    }
    
    @IBAction func handleForwardButton(_ sender: UIButton) {
        let seekTime = CMTimeAdd(player.currentTime(), CMTimeMake(value: 15, timescale: 1))
        player.seek(to: seekTime)
    }
}

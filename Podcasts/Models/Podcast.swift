//
//  Podcast.swift
//  Podcasts
//
//  Created by Emir Alkal on 29.04.2023.
//

import Foundation

struct Podcast: Decodable {
    let trackName: String?
    let artistName: String?
    let profileImage: String?
    let trackCount: Int?
    let feedUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case trackName
        case artistName
        case profileImage = "artworkUrl100"
        case trackCount
        case feedUrl
    }
}

//
//  Episode.swift
//  Podcasts
//
//  Created by Emir Alkal on 1.05.2023.
//

import Foundation
import FeedKit

struct Episode: Decodable {
    let title: String
    let pubDate: Date
    let description: String
    var imageURL: String?
    
    init(feedItem: RSSFeedItem) {
        self.title = feedItem.title ?? ""
        self.pubDate = feedItem.pubDate ?? Date()
        self.description = feedItem.description ?? ""
        self.imageURL = feedItem.iTunes?.iTunesImage?.attributes?.href ?? ""
    }
}

//
//  SearchResponse.swift
//  Podcasts
//
//  Created by Emir Alkal on 29.04.2023.
//

import Foundation

struct SearchResponse: Decodable {
    let resultCount: Int
    let results: [Podcast]
}

//
//  NetworkManager.swift
//  Podcasts
//
//  Created by Emir Alkal on 29.04.2023.
//

import Foundation
import Alamofire

struct NetworkManager {
    static let shared = NetworkManager()
    private init() {}
    private let baseURL = "https://itunes.apple.com/search"
    
    func fetchPodcasts(for searchText: String, completion: @escaping (Result<[Podcast], Error>) -> Void) {
        let parameters = ["term": searchText]
        
        AF.request(baseURL, parameters: parameters, encoding: URLEncoding.default).responseData { response in
            guard response.error == nil else { return }
            guard let data = response.data else { return }
            
            do {
                let decodedObj = try JSONDecoder().decode(SearchResponse.self, from: data)
                completion(.success(decodedObj.results))
            } catch {
                completion(.failure(error))
            }
        }
    }
}

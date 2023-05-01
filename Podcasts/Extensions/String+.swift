//
//  String+.swift
//  Podcasts
//
//  Created by Emir Alkal on 1.05.2023.
//

import Foundation

extension String {
    func toSecureHTTPS() -> String {
        return self.contains("https") ? self : self.replacingOccurrences(of: "http", with: "https")
    }
}

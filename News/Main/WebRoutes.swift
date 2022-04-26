//
//  WebRoutes.swift
//  News
//
//  Created by Ian Grünig on 26.04.22.
//

import Foundation

struct WebRoutes {
    
    static let baseURL = "https://mb21.github.io/blog/tags/"
    static let tags = ["tech", "society", "philosophy", "design", "movies"]
    
    static func urlForTag(_ tag: String) -> URL? {
        if let index = WebRoutes.tags.firstIndex(of: tag) {
            return URL(string: "\(WebRoutes.baseURL)\(WebRoutes.tags[index])")
        }
        return nil
    }
}

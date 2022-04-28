//
//  MockBookmarkFactory.swift
//  NewsTests
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

struct MockBookmarkFactory {
    
    static func randomBookmark() -> Bookmark {
        return Bookmark(id: randomId(), title: randomTitle(), url: randomURL(), createdAt: Date())
    }
    
    static func randomId() -> Int {
        return Int.random(in: 0...100)
    }
    
    static func randomTitle() -> String {
        return UUID().uuidString
    }
    
    static func randomURL() -> URL {
        return URL(string: "https://test.com/\(UUID().uuidString)")!
    }
    
}

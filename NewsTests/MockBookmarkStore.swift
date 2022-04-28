//
//  MockBookmarkStore.swift
//  NewsTests
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

class MockBookmarkStore: SimpleStorage {
    typealias T = Bookmark
    
    var bookmarks: [Bookmark]?
    
    func loadData() -> [Bookmark]? {
        return bookmarks
    }
    
    func saveData(_ data: [Bookmark]) -> Bool {
        bookmarks = data
        return true
    }
}

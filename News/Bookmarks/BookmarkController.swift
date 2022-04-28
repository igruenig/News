//
//  BookmarkController.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

class BookmarkController<P: SimpleStorage> where P.T == Bookmark {
    
    let db: P
    
    private var bookmarks: [Bookmark]
    
    init(db: P) {
        self.db = db
        self.bookmarks = db.loadData() ?? []
    }
    
    func isBookmarked(_ url: String) -> Bool {
        return bookmarks.contains { $0.url.absoluteString == url }
    }
    
    func findAll() -> [Bookmark] {
        return bookmarks
    }
    
    func add(_ url: URL, title: String) -> Bool {
        let newBookmark = Bookmark(id: findAll().count, title: title, url: url, createdAt: Date())
        bookmarks.append(newBookmark)
        return db.saveData(bookmarks)
    }
    
    func remove(_ url: String) -> Bool {
        bookmarks.removeAll { $0.url.absoluteString == url }
        return db.saveData(bookmarks)
    }
    
}

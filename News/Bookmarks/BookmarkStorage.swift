//
//  BookmarkStorage.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

protocol BookmarkStorage {    
    func loadData() -> [Bookmark]?
    func saveData(_ data: [Bookmark]) -> Bool
}

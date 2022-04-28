//
//  BookmarkRepository.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

protocol BookmarkRepository {
    func findAll() -> [Bookmark]
    func get(_ url: String) -> Bookmark?
    func add(_ bookmark: Bookmark)
    func remove(_ url: String)
}

//
//  Bookmark.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

struct Bookmark: Codable {
    let id: Int
    let title: String
    let url: URL
    let createdAt: Date
}

//
//  SimpleStorage.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

protocol SimpleStorage {
    associatedtype T
    
    func loadData() -> [T]?
    func saveData(_ data: [T]) -> Bool
}

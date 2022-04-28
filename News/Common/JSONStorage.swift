//
//  JSONStorage.swift
//  News
//
//  Created by Ian Grünig on 28.04.22.
//

import Foundation

struct JSONStorage<T: Codable>: SimpleStorage {
    
    let fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func loadData() -> [T]? {
        if let url = fileURL(), let data = try? Data(contentsOf: url) {
            return decode(json: data)
        }
        return nil
    }
    
    func saveData(_ data: [T]) -> Bool {
        if let data = encode(objects: data), let url = fileURL() {
            do {
                try data.write(to: url)
            } catch {
                print(error)
                return false
            }
            return true
        }
        return false
    }
    
    private func encode(objects: [T]) -> Data? {
        let jsonEncoder = JSONEncoder()
        return try? jsonEncoder.encode(objects)
    }
    
    private func decode(json: Data) -> [T]? {
        let decoder = JSONDecoder()
        return try? decoder.decode([T].self, from: json)
    }
    
    private func fileURL() -> URL? {
        if let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            return documentDirectory.appendingPathComponent(fileName)
        }
        return nil
    }
    
}

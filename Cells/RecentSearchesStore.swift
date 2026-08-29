//
//  RecentSearchesStore.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 29.08.26.
//

import Foundation

final class RecentSearchesStore {
    static let shared = RecentSearchesStore()
    private init() {}
    
    private let key = "RecentSearches"
    private let maxCount = 10
    
    func fetchAll() -> [String] {
        UserDefaults.standard.stringArray(forKey: key) ?? []
    }
    
    func add(_ query: String) {
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }
        
        var current = fetchAll()
        current.removeAll { $0.caseInsensitiveCompare(trimmed) == .orderedSame }
        current.insert(trimmed, at: 0)
        
        if current.count > maxCount {
            current = Array(current.prefix(maxCount))
        }
        
        UserDefaults.standard.set(current, forKey: key)
    }
    
    func clearAll() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}

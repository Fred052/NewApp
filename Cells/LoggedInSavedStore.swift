//
//  LoggedInSavedStore.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 28.08.26.
//

import Foundation

protocol LoggedInSavedStore {
    func fetchAll() -> [News]
    func isSaved(_ news: News) -> Bool
    func toggle(_ news: News)
    func remove(_ news: News)
}

final class UserDefaultsSavedStore: LoggedInSavedStore {
    static let shared =  UserDefaultsSavedStore()
    private init() {}
    
    private let storageKey = "LoggedInSaved.savedNews"
    
    private func loadFromDisk() -> [News] {
        guard let data = UserDefaults.standard.data(forKey: storageKey) else {
            return []
        }
        guard let decoded = try? JSONDecoder().decode([News].self, from: data) else {
            return []
        }
        return decoded
    }
    
    private func saveToDisk(_ news: [News]) {
        guard let data = try? JSONEncoder().encode(news) else { return }
        UserDefaults.standard.set(data, forKey: storageKey)
    }
    
    func fetchAll() -> [News] {
        return loadFromDisk()
    }
    
    func isSaved(_ news: News) -> Bool {
        let current = loadFromDisk()
        return current.contains { $0.title == news.title}
    }
    
    func toggle(_ news: News) {
        var current = loadFromDisk()
        
        if let index = current.firstIndex(where: {$0.title == news.title}) {
            current.remove(at: index)
        } else {
            current.append(news)
        }
        
        saveToDisk(current)
    }
    
    func remove(_ news: News) {
        var current = loadFromDisk()
        current.removeAll {$0.title == news.title}
        saveToDisk(current)
    }
}

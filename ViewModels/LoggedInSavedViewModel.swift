//
//  LoggedInSavedViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 29.08.26.
//

import Foundation

final class LoggedInSavedViewModel {
    
    private let store: LoggedInSavedStore
    private(set) var savedNews: [News] = []
    
    // ViewController-ə "data dəyişdi, reload et" siqnalı vermək üçün.
    var onDataChanged: (() -> Void)?
    
    init(store: LoggedInSavedStore = UserDefaultsSavedStore.shared) {
        self.store = store
    }
    
    func reload() {
        savedNews = store.fetchAll()
        onDataChanged?()
    }
    
    var numberOfItems: Int {
        savedNews.count
    }
    
    func item(at index: Int) -> News {
        savedNews[index]
    }
    
    func removeBookmark(at index: Int) {
        let news = savedNews[index]
        store.remove(news)
        reload()
    }
}

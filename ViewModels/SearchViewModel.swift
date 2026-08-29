//
//  SearchViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 29.08.26.
//

import Foundation

final class SearchViewModel {
    
    private let allNews: [News]
    
    private(set) var recentSearches: [String] = []
    
    let trendingTopics: [TrendingTopic] = [
        TrendingTopic(rank: "01", title: "AI Regulation"),
        TrendingTopic(rank: "02", title: "Climate Summit"),
        TrendingTopic(rank: "03", title: "Nasdaq"),
        TrendingTopic(rank: "04", title: "Mars Sample Return"),
        TrendingTopic(rank: "05", title: "Bundesliga"),
        TrendingTopic(rank: "06", title: "Election Night")
    ]
    
    private(set) var searchResults: [News] = []
    private(set) var currentQuery: String = ""
    
    init(allNews: [News] = NewsLoader.loadNews()) {
        self.allNews = allNews
        reloadRecentSearches()
    }
    
    var allNewsItems: [News] {
        allNews
    }
    
    var isShowingResults: Bool {
        !currentQuery.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    var resultsCountText: String {
        let count = searchResults.count
        let storyWord = count == 1 ? "story" : "stories"
        return "\(count) \(storyWord) for \"\(currentQuery)\""
    }
    
    func reloadRecentSearches() {
        recentSearches = RecentSearchesStore.shared.fetchAll()
    }
    
    func clearRecentSearches() {
        RecentSearchesStore.shared.clearAll()
        reloadRecentSearches()
    }
    
    func updateQuery(_ query: String) {
        currentQuery = query
        
        let trimmed = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else {
            searchResults = []
            return
        }
        
        searchResults = allNews.filter {
            $0.title.range(of: trimmed, options: .caseInsensitive) != nil ||
            $0.category.range(of: trimmed, options: .caseInsensitive) != nil ||
            $0.source.range(of: trimmed, options: .caseInsensitive) != nil
        }
    }
    
    func commitSearch() {
        guard isShowingResults else { return }
        RecentSearchesStore.shared.add(currentQuery)
        reloadRecentSearches()
    }
    
    func clearQuery() {
        currentQuery = ""
        searchResults = []
    }
    
    func numberOfResults() -> Int {
        searchResults.count
    }
    
    func result(at index: Int) -> News {
        searchResults[index]
    }
}

//
//  ArticleViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 29.08.26.
//
import Foundation

final class ArticleViewModel {
    
    let news: News
    private let allNews: [News]
    
    init(news: News, allNews: [News]) {
        self.news = news
        self.allNews = allNews
    }
    
    var category: String {
        news.category.uppercased()
    }
    
    var title: String {
        news.title
    }
    
    var source: String {
        news.source
    }
    
    var imageName: String {
        news.imageName
    }
    
    var quote: String {
        news.quote
    }
    
    var metaText: String {
        "\(news.publishedAt) · \(estimatedReadTime) min read"
    }
    
    var paragraphs: [String] {
        news.content.components(separatedBy: "\n\n")
    }
    
    var relatedNews: [News] {
        Array(
            allNews
                .filter { $0.category == news.category && $0.title != news.title }
                .prefix(3)
        )
    }
    
    var isSaved: Bool {
        UserDefaultsSavedStore.shared.isSaved(news)
    }
    
    private var estimatedReadTime: Int {
        let wordCount = news.content.split(separator: " ").count
        return max(1, Int((Double(wordCount) / 200.0).rounded(.up)))
    }
    
    func toggleSave() {
        UserDefaultsSavedStore.shared.toggle(news)
    }
}

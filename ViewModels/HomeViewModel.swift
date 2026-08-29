//
//  HomeViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 25.08.26.
//

import Foundation

final class HomeViewModel {
    
    let categories: [Category] = [
           Category(name: "For You"),
           Category(name: "World"),
           Category(name: "Technology"),
           Category(name: "Business"),
           Category(name: "Sports"),
           Category(name: "Science"),
           Category(name: "Entertainment")
       ]
    
    private let allNews: [News]
    private(set) var news: [News] = []
    
    init() {
        allNews = NewsLoader.loadNews()
        news = allNews
    }

    var numberOfItems: Int {
        news.count
    }

    func item(at index: Int) -> News {
        news[index]
    }
    
    var allNewsItems: [News] {
        allNews
    }
    
    // Jsondaki categoriesler eyni olduguna gore bu funcla onlardan istifade edirik
    func filterNews(by category: Category) {
        if category.name == "For You" {
            news = allNews
        } else {
            news = allNews.filter {
                $0.category.caseInsensitiveCompare(category.name) == .orderedSame
            }
        }
    }
}

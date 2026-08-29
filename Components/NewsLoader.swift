//
//  NewsLoader.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 27.08.26.
//

import Foundation

enum NewsLoader {
    static func loadNews(from fileName: String = "NewsData") -> [News] {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            print("⚠️ \(fileName).json not founded")
            return []
        }
        
        do {
            let data = try Data(contentsOf: url)
            let news = try JSONDecoder().decode([News].self, from: data)
            return news
        } catch {
            print("Json decode error", error)
            return []
        }
    }
}

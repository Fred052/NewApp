//
//  News.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 25.08.26.
//

import Foundation

struct News: Codable {
    let category: String
    let title: String
    let source: String
    let publishedAt: String
    let summary: String
    let content: String
    let quote: String
    let imageName: String
}

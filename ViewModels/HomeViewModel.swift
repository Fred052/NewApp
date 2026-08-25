//
//  HomeViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 25.08.26.
//

import Foundation

final class HomeViewModel {

    let news: [News] = [

        News(
            category: "TECHNOLOGY",
            title: "Apple's Next Generation of AI Is About to Change the iPhone",
            description: "A new on-device model runs entirely offline, and the company says nothing leaves the handset.",
            source: "Reuters",
            time: "2h ago",
            imageName: "news1"
        ),

        News(
            category: "WORLD",
            title: "Europe Records Its Brightest Solar Summer",
            description: "Energy production continues to increase across Europe.",
            source: "Associated Press",
            time: "3h ago",
            imageName: "news2"
        ),

        News(
            category: "BUSINESS",
            title: "Markets Continue to Show Strong Growth This Week",
            description: "Investors are closely watching the latest developments.",
            source: "Bloomberg",
            time: "4h ago",
            imageName: "news3"
        ),

        News(
            category: "SPORTS",
            title: "A New Season Begins With Exciting Matches",
            description: "Teams are preparing for another important week.",
            source: "ESPN",
            time: "5h ago",
            imageName: "news4"
        )
    ]

    var numberOfItems: Int {
        news.count
    }

    func item(at index: Int) -> News {
        news[index]
    }
}

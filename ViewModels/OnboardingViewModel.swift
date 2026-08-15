//
//  OnboardingViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 14.08.26.
//

import Foundation

final class OnboardingViewModel {
    
    let pages: [OnboardingPage] = [
        
        OnboardingPage(
            imageName: "onboarding1",
            eyebrow: "DISCOVER WHAT'S HAPPENING",
            title: "Stay Informed.\nStay Ahead.",
            description: "Discover the stories that matter, from the world around you to the topics you care about."
        ),
        OnboardingPage(
            imageName: "onboarding2",
            eyebrow: "Your news, your interests",
            title: "News That Fits You.",
            description: "Explore the topics you love and quickly find stories that match your interests."
        ),
        OnboardingPage(
            imageName: "onboarding3",
            eyebrow: "Save what matters",
            title: "Save Stories for \nLater.",
            description: "Bookmark the stories you want to come back to anytime."
        )
    ]
    
    private(set)  var currentPage = 0
    
    var numberOfPages: Int {
        pages.count
    }
    
    var isLastPage: Bool {
        currentPage == pages.count - 1
    }
    
    func page(at index: Int) -> OnboardingPage {
        pages[index]
    }
    
    func moveToNextPage() -> Bool {
        
        guard !isLastPage else {
            return false
        }
        
        currentPage += 1
        
        return true
        
    }
    
    func moveToPage(_ index: Int) {
        guard pages.indices.contains(index) else {
            return
        }
        
        currentPage = index
    }
}

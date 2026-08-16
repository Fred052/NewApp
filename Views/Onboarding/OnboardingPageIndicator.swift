//
//  OnboardingPageIndicator.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 15.08.26.
//

import UIKit

final class  OnboardingPageIndicator: UIView {
    
    private var indicators: [UIView] = []
    
    private let pageCount: Int
    private var currentPage: Int
    
    init(pageCount: Int, currentPage: Int = 0) {
        
        self.pageCount = pageCount
        self.currentPage = currentPage
        
        super.init(frame: .zero)
        
        setupIndicator()
        setupContraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func  setupIndicator() {
        for index in 0..<pageCount {
            let indicator = UIView()
            
            indicator.backgroundColor = index == currentPage ? .black :UIColor.black.withAlphaComponent(0.18)
            
            indicator.layer.cornerRadius = 3
            
            indicator.translatesAutoresizingMaskIntoConstraints = false
            
            addSubview(indicator)
            
            indicators.append(indicator)
        }
        
    }
    
    
    private func setupContraints() {
        
        for index in 0..<indicators.count {
            
            let indicator = indicators[index]
            
            NSLayoutConstraint.activate([
                indicator.centerYAnchor.constraint(equalTo: centerYAnchor),
                indicator.heightAnchor.constraint(equalToConstant: 6),
                indicator.widthAnchor.constraint(equalToConstant: index == currentPage ? 20 : 6)
            ])
            
            if index == 0 {
                
                indicator.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            } else {
                
                indicator.leadingAnchor.constraint(equalTo: indicators[index - 1].trailingAnchor, constant: 7).isActive = true
            }
        }
        
        if let lastIndicator = indicators.last {
            
            lastIndicator.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    }
    
    func update(currentPage: Int) {
        self.currentPage = currentPage
        
        for(index, indicator) in indicators.enumerated() {
            indicator.backgroundColor = index == currentPage
            ? .black
            : UIColor.black.withAlphaComponent(0.18)
            
            for constraint in indicator.constraints {
                if constraint.firstAttribute == .width {
                    constraint.constant =
                    index == currentPage ? 20 : 6
                }
            }
        }
    }
}

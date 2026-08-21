//
//  AppButton.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 21.08.26.
//

import UIKit

enum AppButtonStyle {
    case primary
    case apple
}

final class AppButton: UIButton {
    
    init(title: String, style: AppButtonStyle) {
        super.init(frame: .zero)
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        tintColor = .white
        titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        layer.cornerRadius = 15
        
        switch style {
        case .primary:
            backgroundColor = UIColor(red: 0.72, green: 0.11, blue: 0.14, alpha: 1)
            
        case .apple:
            backgroundColor = .black
            setImage(UIImage(systemName: "apple.logo"), for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

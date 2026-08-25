//
//  PrimaryButton.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 18.08.26.
//
import UIKit

final class PrimaryButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        translatesAutoresizingMaskIntoConstraints = false
        
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        
        titleLabel?.font = .systemFont(
            ofSize: 18,
            weight: .bold
        )
        
        backgroundColor = UIColor(
            red: 0.72,
            green: 0.08,
            blue: 0.11,
            alpha: 1
        )
        
        layer.cornerRadius = 26
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

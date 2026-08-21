//
//  HomeViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 15.08.26.
//

import UIKit

final class HomeViewController: UIViewController {
    
    private let favoriteButton: UIButton = {
       let button = UIButton()
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .white
        button.layer.cornerRadius = 22
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        
        setupUI()
        setupAction()
    }
    
    
    private func setupUI() {
        view.addSubview(favoriteButton)
        
        NSLayoutConstraint.activate([
            favoriteButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favoriteButton.widthAnchor.constraint(equalToConstant: 44),
            favoriteButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    private func setupAction() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped), for: .touchUpInside)
    }
    
    @objc private func favoriteButtonTapped() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "isLoggedIn")
        
        if isLoggedIn {
            let favoriteViewController = FavoriteViewController()
            navigationController?.pushViewController(favoriteViewController, animated: true)
        } else {
            let loginViewController = LoginViewController()
            navigationController?.pushViewController(loginViewController, animated: true)
        }
    }
}

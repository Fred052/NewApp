//
//  ProfileViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 23.08.26.
//

import UIKit

final class ProfileViewController: UIViewController {
    private let viewModel = ProfileViewModel()
    
    private lazy var  profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Profile")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.font = UIFont(name: "IowanOldStyle-Roman", size: 19) ?? .systemFont(ofSize: 46)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let signInButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        
        configuration.title = "Sign In"
        configuration.baseBackgroundColor = .reds
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .large
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 13, leading: 30, bottom: 13, trailing: 30)
        
        configuration.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { attributes in
                var updatedAttributes = attributes
                updatedAttributes.font = .systemFont(
                    ofSize: 15,
                    weight: .bold
                )
                return updatedAttributes
            }
        
        let button = UIButton(configuration: configuration)
          button.translatesAutoresizingMaskIntoConstraints = false
          
          return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        configure()
        setupActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true , animated: false)
    }
    
    private func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(profileImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -145),
            profileImageView.widthAnchor.constraint(equalToConstant: 58),
            profileImageView.heightAnchor.constraint(equalToConstant: 58),
            
            titleLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            signInButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configure() {
        titleLabel.text = viewModel.titleText
        descriptionLabel.text = viewModel.descriptionText
        signInButton.setTitle(viewModel.signInButtonTitle, for: .normal)
    }
    
    private func setupActions() {
        signInButton.addTarget(self, action: #selector(sigInButtonTapped), for: .touchUpInside)
    }
    
    @objc private func  sigInButtonTapped() {
        let loginViewController = LoginViewController()
        loginViewController.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(loginViewController, animated: true)
    }
}

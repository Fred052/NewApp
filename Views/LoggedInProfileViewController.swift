//
//  LoggedInProfileViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 24.08.26.
//

import UIKit

final class LoggedInProfileViewController: UIViewController {
    
    private let viewModel = LoggedInProfileViewModel()
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Profile1")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 82 / 2
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var  nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "IowanOldStyle-Roman",
                            size: 24
                        ) ?? .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label .textColor = .systemGray
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var menuCard: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 22
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray5.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var savedButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Saved Stories"
        configuration.image = UIImage(systemName: "bookmark")
        configuration.imagePadding = 15
        configuration.baseBackgroundColor = .black
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 22,
            bottom: 16,
            trailing: 22
        )
        
        let button = UIButton(configuration: configuration)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var savedCountLabel: UILabel = {
       let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var savedChevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var settingsButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.title = "Settings"
        configuration.image = UIImage(systemName: "gearshape")
        configuration.imagePadding = 15
        configuration.baseForegroundColor = .black
        configuration.contentInsets = NSDirectionalEdgeInsets(
            top: 16,
            leading: 22,
            bottom: 16,
            trailing: 22
        )
        
        let button = UIButton(configuration: configuration)
        button.contentHorizontalAlignment = .leading
        button.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        button.tintColor = .black
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var settingChevronImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
        imageView.tintColor = .systemGray3
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var logOutButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        configuration.title = "Log Out"
        configuration.baseBackgroundColor = .white
        configuration.baseForegroundColor = .reds
        configuration.cornerStyle = .large
        
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
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupActions()
        configure()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true , animated: false)
        configure()
    }
    
    private func setupUI() {
        view.backgroundColor = .background
        
        [
            profileImageView,
            nameLabel,
            emailLabel,
            menuCard,
            logOutButton
        ].forEach(view.addSubview)
        
        [
            savedButton,
            savedCountLabel,
            savedChevronImageView,
            separatorView,
            settingsButton,
            settingChevronImageView
        ].forEach(menuCard.addSubview)
        
        NSLayoutConstraint.activate([
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 82),
            profileImageView.heightAnchor.constraint(equalToConstant: 82),
            
            nameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            nameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            emailLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            
            menuCard.topAnchor.constraint(equalTo: emailLabel.bottomAnchor, constant: 25),
            menuCard.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            menuCard.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            menuCard.heightAnchor.constraint(equalToConstant: 120),
            
            savedButton.topAnchor.constraint(equalTo: menuCard.topAnchor, constant: 4),
            savedButton.leadingAnchor.constraint(equalTo: menuCard.leadingAnchor),
            savedButton.trailingAnchor.constraint(equalTo: menuCard.trailingAnchor),
            savedButton.heightAnchor.constraint(equalToConstant: 55),
            
            savedChevronImageView.centerYAnchor.constraint(equalTo: savedButton.centerYAnchor),
            savedChevronImageView.trailingAnchor.constraint(equalTo: menuCard.trailingAnchor, constant: -26),
            
            savedCountLabel.centerYAnchor.constraint(equalTo: savedButton.centerYAnchor),
            savedCountLabel.trailingAnchor.constraint(equalTo: savedChevronImageView.leadingAnchor, constant: -18),
            
            separatorView.topAnchor.constraint(equalTo: savedButton.bottomAnchor),
            separatorView.leadingAnchor.constraint(equalTo: menuCard.leadingAnchor, constant: 70),
            separatorView.trailingAnchor.constraint(equalTo: menuCard.trailingAnchor),
            separatorView.heightAnchor.constraint(equalToConstant: 1),
            
            settingsButton.topAnchor.constraint(equalTo: separatorView.bottomAnchor, constant: 4),
            settingsButton.leadingAnchor.constraint(equalTo: menuCard.leadingAnchor),
            settingsButton.trailingAnchor.constraint(equalTo: menuCard.trailingAnchor),
            settingsButton.heightAnchor.constraint(equalToConstant: 55),
            
            settingChevronImageView.centerYAnchor.constraint(equalTo: settingsButton.centerYAnchor),
            settingChevronImageView.trailingAnchor.constraint(equalTo: menuCard.trailingAnchor, constant: -26),
            
            logOutButton.topAnchor.constraint(equalTo: menuCard.bottomAnchor, constant: 15),
            logOutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            logOutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            logOutButton.heightAnchor.constraint(equalToConstant: 55)
        ])
    }
    
    private func configure() {
        nameLabel.text = viewModel.fullName
        emailLabel.text = viewModel.email
        savedCountLabel.text = viewModel.savedStoryCount
    }
    
    private func setupActions() {
        savedButton.addTarget(self, action: #selector(savedTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
        logOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
    }
    
    @objc private func savedTapped() {
        tabBarController?.selectedIndex = 2
    }
    
    @objc private func settingsTapped() {
        
    }
    
    @objc private func logOutTapped() {
        viewModel.logOut()
        view.window?.rootViewController = MainTabBarController()
    }
    
}


//
//  SavedViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 23.08.26.
//

import UIKit

final class SavedViewController: UIViewController {
    private let viewModel = SavedViewModel()
    
    private let headerTitleLabel: UILabel = {
      let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name: "IowanOldStyle-Roman", size: 32) ?? .systemFont(ofSize: 46)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let headerDescriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        label.font = UIFont.systemFont(ofSize: 13.5, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var  bookmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "bookmark")
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
        
        view.addSubview(headerTitleLabel)
        view.addSubview(headerDescriptionLabel)
        view.addSubview(bookmarkImageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(signInButton)
        
        NSLayoutConstraint.activate([
            headerTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            headerDescriptionLabel.topAnchor.constraint(equalTo: headerTitleLabel.bottomAnchor, constant: 8),
            headerDescriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            
            bookmarkImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            bookmarkImageView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -55),
            bookmarkImageView.widthAnchor.constraint(equalToConstant: 68),
            bookmarkImageView.heightAnchor.constraint(equalToConstant: 68),
            
            titleLabel.topAnchor.constraint(equalTo: bookmarkImageView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 13),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 45),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -45),
            
            signInButton.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 32),
            signInButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    private func configure() {
        headerTitleLabel.text = viewModel.headerTitle
        headerDescriptionLabel.text = viewModel.headerDescription
        titleLabel.text = viewModel.emptyTitle
        descriptionLabel.text = viewModel.emptyDescrtiption
    }
    
    private func setupActions() {
        signInButton.addTarget(self, action: #selector(sigInButtonTapped), for: .touchUpInside)
    }
    
    @objc private func  sigInButtonTapped() {
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}


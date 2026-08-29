//
//  SaveStoryPromptViewController.swift
//  NewApp
//

import UIKit

final class SaveStoryPromptViewController: UIViewController {
    
    var onSignInTapped: (() -> Void)?
    var onNotNowTapped: (() -> Void)?
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.alpha = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 28
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var grabberView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        view.layer.cornerRadius = 2.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.reds.withAlphaComponent(0.1)
        view.layer.cornerRadius = 22
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var iconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "bookmark.fill"))
        imageView.tintColor = .reds
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Save this story"
        label.font = UIFont(name: "IowanOldStyle-Roman", size: 26) ?? .systemFont(ofSize: 26, weight: .bold)
        label.textColor = .black
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign in to save articles and access them anytime."
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray
        label.textAlignment = .center
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var signInButton: UIButton = {
        var configuration = UIButton.Configuration.filled()
        
        configuration.title = "Sign In"
        configuration.baseBackgroundColor = .reds
        configuration.baseForegroundColor = .white
        configuration.cornerStyle = .large
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 30, bottom: 16, trailing: 30)
        
        configuration.titleTextAttributesTransformer =
            UIConfigurationTextAttributesTransformer { attributes in
                var updatedAttributes = attributes
                updatedAttributes.font = .systemFont(ofSize: 17, weight: .bold)
                return updatedAttributes
            }
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var notNowButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Not Now", for: .normal)
        button.setTitleColor(.systemGray, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(notNowTapped), for: .touchUpInside)
        return button
    }()
    
    private var cardBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        setupUI()
        
        let dimTap = UITapGestureRecognizer(target: self, action: #selector(notNowTapped))
        blurEffectView.addGestureRecognizer(dimTap)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        animateIn()
    }
    
    private func setupUI() {
        view.addSubview(blurEffectView)
        view.addSubview(cardView)
        
        cardView.addSubview(grabberView)
        cardView.addSubview(iconBackgroundView)
        iconBackgroundView.addSubview(iconImageView)
        cardView.addSubview(titleLabel)
        cardView.addSubview(subtitleLabel)
        cardView.addSubview(signInButton)
        cardView.addSubview(notNowButton)
        
        cardBottomConstraint = cardView.topAnchor.constraint(equalTo: view.bottomAnchor)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            cardBottomConstraint,
            cardView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            cardView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            grabberView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 12),
            grabberView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            grabberView.widthAnchor.constraint(equalToConstant: 40),
            grabberView.heightAnchor.constraint(equalToConstant: 5),
            
            iconBackgroundView.topAnchor.constraint(equalTo: grabberView.bottomAnchor, constant: 24),
            iconBackgroundView.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            iconBackgroundView.widthAnchor.constraint(equalToConstant: 68),
            iconBackgroundView.heightAnchor.constraint(equalToConstant: 68),
            
            iconImageView.centerXAnchor.constraint(equalTo: iconBackgroundView.centerXAnchor),
            iconImageView.centerYAnchor.constraint(equalTo: iconBackgroundView.centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 28),
            iconImageView.heightAnchor.constraint(equalToConstant: 28),
            
            titleLabel.topAnchor.constraint(equalTo: iconBackgroundView.bottomAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 36),
            subtitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -36),
            
            signInButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 28),
            signInButton.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 24),
            signInButton.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -24),
            signInButton.heightAnchor.constraint(equalToConstant: 54),
            
            notNowButton.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 16),
            notNowButton.centerXAnchor.constraint(equalTo: cardView.centerXAnchor),
            notNowButton.bottomAnchor.constraint(equalTo: cardView.safeAreaLayoutGuide.bottomAnchor, constant: -16)
        ])
    }
    
    private func animateIn() {
        cardBottomConstraint.isActive = false
        cardBottomConstraint = cardView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        cardBottomConstraint.isActive = true
        
        UIView.animate(
            withDuration: 0.35,
            delay: 0,
            usingSpringWithDamping: 0.9,
            initialSpringVelocity: 0.4,
            options: .curveEaseOut
        ) {
            self.blurEffectView.alpha = 1
            self.view.layoutIfNeeded()
        }
    }
    
    private func animateOut(completion: @escaping () -> Void) {
        cardBottomConstraint.isActive = false
        cardBottomConstraint = cardView.topAnchor.constraint(equalTo: view.bottomAnchor)
        cardBottomConstraint.isActive = true
        
        UIView.animate(
            withDuration: 0.25,
            animations: {
                self.blurEffectView.alpha = 0
                self.view.layoutIfNeeded()
            },
            completion: { _ in
                completion()
            }
        )
    }
    
    @objc private func signInTapped() {
        animateOut { [weak self] in
            self?.dismiss(animated: false) {
                self?.onSignInTapped?()
            }
        }
    }
    
    @objc private func notNowTapped() {
        animateOut { [weak self] in
            self?.dismiss(animated: false) {
                self?.onNotNowTapped?()
            }
        }
    }
}

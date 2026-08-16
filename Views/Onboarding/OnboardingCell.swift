//
//  OnboardingCell.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 15.08.26.
//
import UIKit

final class OnboardingCell: UICollectionViewCell {
    
    static let identifier = "OnboardingCell"
    
    var continueAction: (() -> Void)?
    
    private let backgroundImageView: UIImageView = {
        
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let eyebrowLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(red: 0.72, green: 0.05, blue: 0.08, alpha: 1)
        label.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = .black
        label.font = UIFont(name: "Georgia", size: 40)
        
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        
        label.textColor = UIColor(white: 0.35, alpha: 1)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Continue", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = UIColor(red: 0.72, green: 0.05, blue: 0.08, alpha: 1)
        button.layer.cornerRadius = 16
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
        
    }()
    
    private let pageIndicator = OnboardingPageIndicator(pageCount: 3)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()
        
        continueButton.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
    }
    
    @objc private func continueButtonTapped() {
        continueAction?()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        
        contentView.backgroundColor = .white
        
        contentView.addSubview(backgroundImageView)
        contentView.addSubview(eyebrowLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(pageIndicator)
        contentView.addSubview(continueButton)
        
        pageIndicator.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            backgroundImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.60),
            
            eyebrowLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            eyebrowLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
            eyebrowLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 540),
            
            titleLabel.leadingAnchor.constraint(equalTo: eyebrowLabel.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: eyebrowLabel.trailingAnchor),
            titleLabel.topAnchor.constraint(equalTo: eyebrowLabel.bottomAnchor, constant: 12),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            descriptionLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 18),
            
            pageIndicator.leadingAnchor.constraint(equalTo: continueButton.leadingAnchor),
            pageIndicator.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -14),
            pageIndicator.heightAnchor.constraint(equalToConstant: 6),
            pageIndicator.widthAnchor.constraint(equalToConstant: 46),
            
            continueButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 28),
            continueButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -28),
            continueButton.heightAnchor.constraint(equalToConstant: 54),
            continueButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -28)
        ])
    }
    
    func configure(with page: OnboardingPage, buttonTitle: String, currentPage: Int) {
        
        backgroundImageView.image = UIImage(named: page.imageName)
        
        eyebrowLabel.text = page.eyebrow
        titleLabel.text = page.title
        descriptionLabel.text = page.description
        continueButton.setTitle(buttonTitle, for: .normal)
        pageIndicator.update(currentPage: currentPage)
    }
}


//
//  NewsTableViewCell.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 25.08.26.
//

import UIKit

final class NewsTableViewCell: UITableViewCell {
    static let identifier = "NewsTableViewCell"
    
    var onbookmarkTapped: (() -> Void)?
    
    private var isBookmarked: Bool = false {
        didSet {
            let imageName = isBookmarked ? "bookmark.fill" : "bookmark"
            bookmarkButton.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var overlayView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 11, weight: .bold)
        label.textColor = .systemRed
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Georgia", size: 28)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.textColor = .white
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        button.layer.cornerRadius = 12
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(bookmarkButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(
        style: UITableViewCell.CellStyle,
        reuseIdentifier: String?
    ) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        onbookmarkTapped = nil
        isBookmarked = false
    }
    
    private func setupUI() {
        
        selectionStyle = .none
        
        contentView.addSubview(containerView)
        contentView.addSubview(newsImageView)
        contentView.addSubview(overlayView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
            
            newsImageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            overlayView.topAnchor.constraint(equalTo: containerView.topAnchor),
            overlayView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            overlayView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            overlayView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            
            categoryLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            categoryLabel.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -10),
            
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            titleLabel.bottomAnchor.constraint(equalTo: descriptionLabel.topAnchor, constant: -16),
            
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            descriptionLabel.bottomAnchor.constraint(equalTo: sourceLabel.topAnchor, constant: -24),
            
            sourceLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 24),
            sourceLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28),
            
            bookmarkButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -24),
            bookmarkButton.centerYAnchor.constraint(equalTo: sourceLabel.centerYAnchor),
            bookmarkButton.widthAnchor.constraint(equalToConstant: 40),
            bookmarkButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func bookmarkButtonTapped() {
        onbookmarkTapped?()
    }
    
    func setBookmarked(_ bookmarked: Bool) {
        isBookmarked = bookmarked
    }
    
     func configure(with news: News, isbookmarked: Bool = false) {
        categoryLabel.text = news.category
        titleLabel.text = news.title
        descriptionLabel.text = news.summary
        
        sourceLabel.text = "\(news.source) · \(news.publishedAt)"
        
        newsImageView.image = UIImage(named: news.imageName)
         
         self.isBookmarked = isbookmarked
    }
}

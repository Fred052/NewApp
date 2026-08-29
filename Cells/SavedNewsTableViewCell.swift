//
//  SavedNewsTableViewCell.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 28.08.26.
//

import UIKit

protocol SavedNewsTableViewCellDelegate: AnyObject {
    func savedNewsCellDidTapBookmark(_ cell: SavedNewsTableViewCell)
}

final class SavedNewsTableViewCell: UITableViewCell {
    static let identifier = "savedNewsTableViewCell"
    
    weak var delegate: SavedNewsTableViewCellDelegate?
    
    private lazy var thumbnailImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .secondarySystemBackground
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        label.font = UIFont(name: "Georgia-Bold", size: 17) ?? .systemFont(ofSize: 17, weight: .bold)
        label.textColor = .label
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        button.tintColor = .systemRed
        button.addTarget(self, action: #selector(bookmarkTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        delegate = nil
    }
    
    private func setupUI() {
        selectionStyle = .none
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(categoryLabel)
        contentView.addSubview(titleLabel)
        contentView.addSubview(sourceLabel)
        contentView.addSubview(bookmarkButton)
        
        NSLayoutConstraint.activate([
                    thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
                    thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
                    thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
                    thumbnailImageView.widthAnchor.constraint(equalToConstant: 84),
                    thumbnailImageView.heightAnchor.constraint(equalToConstant: 84),
                    
                    bookmarkButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
                    bookmarkButton.centerYAnchor.constraint(equalTo: thumbnailImageView.centerYAnchor),
                    bookmarkButton.widthAnchor.constraint(equalToConstant: 24),
                    bookmarkButton.heightAnchor.constraint(equalToConstant: 24),
                    
                    categoryLabel.topAnchor.constraint(equalTo: thumbnailImageView.topAnchor, constant: 2),
                    categoryLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 14),
                    categoryLabel.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -8),
                    
                    titleLabel.topAnchor.constraint(equalTo: categoryLabel.bottomAnchor, constant: 4),
                    titleLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 14),
                    titleLabel.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -8),
                    
                    sourceLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
                    sourceLabel.leadingAnchor.constraint(equalTo: thumbnailImageView.trailingAnchor, constant: 14),
                    sourceLabel.trailingAnchor.constraint(equalTo: bookmarkButton.leadingAnchor, constant: -8)
                ])
    }
    
    @objc private func bookmarkTapped() {
        delegate?.savedNewsCellDidTapBookmark(self)
    }
    
    func configure(with news: News) {
        categoryLabel.text = news.category.uppercased()
        titleLabel.text = news.title
        sourceLabel.text = "\(news.source) · \(news.publishedAt)"
        thumbnailImageView.image = UIImage(named: news.imageName)
    }
}

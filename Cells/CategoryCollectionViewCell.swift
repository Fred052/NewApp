//
//  CategoryCollectionViewCell.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 27.08.26.
//

import UIKit

final class CategoryCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "CategoryCollectionViewCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .medium)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var indicatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .label
        view.layer.cornerRadius = 1.5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(indicatorView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            indicatorView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 6),
            indicatorView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            indicatorView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            indicatorView.heightAnchor.constraint(equalToConstant: 3),
            indicatorView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(
        with category: Category,
        isSelected: Bool
    ) {
        titleLabel.text = category.name
        titleLabel.font = .systemFont(ofSize: 16, weight: isSelected ? .bold : .medium)
        titleLabel.textColor = isSelected ? .label : .secondaryLabel
        
        indicatorView.isHidden = !isSelected
    }
}

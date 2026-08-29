//
//  ArticleViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 29.08.26.
//
import UIKit

final class ArticleViewController: UIViewController {
    
    private let viewModel: ArticleViewModel
    
    init(news: News, allNews: [News]) {
        self.viewModel = ArticleViewModel(news: news, allNews: allNews)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var heroImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.withAlphaComponent(0.65).cgColor
        ]
        layer.locations = [0.4, 1.0]
        return layer
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.35)
        button.layer.cornerRadius = 20
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var heroCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var heroTitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "IowanOldStyle-Roman", size: 30) ?? .systemFont(ofSize: 30, weight: .bold)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var metaLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var saveButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "bookmark")
        configuration.title = "Save"
        configuration.imagePadding = 6
        configuration.baseForegroundColor = .black
        configuration.background.backgroundColor = .secondarySystemBackground
        configuration.background.cornerRadius = 18
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16)
        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { attributes in
            var updated = attributes
            updated.font = .systemFont(ofSize: 14, weight: .semibold)
            return updated
        }
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var shareButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "square.and.arrow.up")
        configuration.baseForegroundColor = .black
        configuration.background.backgroundColor = .secondarySystemBackground
        configuration.background.cornerRadius = 18
        configuration.contentInsets = NSDirectionalEdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 12)
        
        let button = UIButton(configuration: configuration)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(shareTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var topSeparator: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Content
    
    private lazy var paragraphsStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private lazy var quoteTopLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var quoteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "IowanOldStyle-Italic", size: 20) ?? .italicSystemFont(ofSize: 20)
        label.textColor = .reds
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var quoteBottomLine: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var relatedHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "RELATED STORIES"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var relatedStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 18
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupUI()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        updateSaveButtonAppearance()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = heroImageView.bounds
    }
    
    private func setupUI() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        [heroImageView, backButton, heroCategoryLabel, heroTitleLabel].forEach {
            contentView.addSubview($0)
        }
        heroImageView.layer.addSublayer(gradientLayer)
        
        [sourceLabel, metaLabel, saveButton, shareButton, topSeparator,
         paragraphsStackView, quoteTopLine, quoteLabel, quoteBottomLine,
         relatedHeaderLabel, relatedStackView].forEach {
            contentView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            heroImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            heroImageView.heightAnchor.constraint(equalToConstant: 460),
            
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            backButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            backButton.widthAnchor.constraint(equalToConstant: 40),
            backButton.heightAnchor.constraint(equalToConstant: 40),
            
            heroCategoryLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            heroCategoryLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            heroTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            heroTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            heroTitleLabel.bottomAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: -24),

            sourceLabel.topAnchor.constraint(equalTo: heroImageView.bottomAnchor, constant: 18),
            sourceLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            metaLabel.topAnchor.constraint(equalTo: sourceLabel.bottomAnchor, constant: 2),
            metaLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            shareButton.centerYAnchor.constraint(equalTo: sourceLabel.centerYAnchor, constant: 8),
            shareButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            saveButton.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor),
            saveButton.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10),
            
            topSeparator.topAnchor.constraint(equalTo: metaLabel.bottomAnchor, constant: 18),
            topSeparator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            topSeparator.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            topSeparator.heightAnchor.constraint(equalToConstant: 1),

            paragraphsStackView.topAnchor.constraint(equalTo: topSeparator.bottomAnchor, constant: 22),
            paragraphsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            paragraphsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            quoteTopLine.topAnchor.constraint(equalTo: paragraphsStackView.bottomAnchor, constant: 28),
            quoteTopLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quoteTopLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            quoteTopLine.heightAnchor.constraint(equalToConstant: 1),
            
            quoteLabel.topAnchor.constraint(equalTo: quoteTopLine.bottomAnchor, constant: 18),
            quoteLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quoteLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            
            quoteBottomLine.topAnchor.constraint(equalTo: quoteLabel.bottomAnchor, constant: 18),
            quoteBottomLine.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            quoteBottomLine.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            quoteBottomLine.heightAnchor.constraint(equalToConstant: 1),
            
            relatedHeaderLabel.topAnchor.constraint(equalTo: quoteBottomLine.bottomAnchor, constant: 28),
            relatedHeaderLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            relatedStackView.topAnchor.constraint(equalTo: relatedHeaderLabel.bottomAnchor, constant: 16),
            relatedStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            relatedStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            relatedStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -32)
        ])
    }
    
    private func configure() {
        heroImageView.image = UIImage(named: viewModel.imageName)
        heroCategoryLabel.text = viewModel.category
        heroTitleLabel.text = viewModel.title
        
        sourceLabel.text = viewModel.source
        metaLabel.text = viewModel.metaText
        
        paragraphsStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for paragraph in viewModel.paragraphs {
            let label = UILabel()
            label.text = paragraph
            label.font = .systemFont(ofSize: 16)
            label.textColor = .black
            label.numberOfLines = 0
            label.setContentCompressionResistancePriority(.required, for: .vertical)
            paragraphsStackView.addArrangedSubview(label)
        }
        
        quoteLabel.text = "\u{201C}\(viewModel.quote)\u{201D}"
        
        relatedStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        for related in viewModel.relatedNews {
            let relatedView = RelatedStoryView()
            relatedView.configure(with: related)
            relatedView.onTap = { [weak self] in
                self?.openArticle(for: related)
            }
            relatedStackView.addArrangedSubview(relatedView)
        }
        
        updateSaveButtonAppearance()
    }
    
    private func updateSaveButtonAppearance() {
        let isSaved = viewModel.isSaved
        saveButton.configuration?.image = UIImage(systemName: isSaved ? "bookmark.fill" : "bookmark")
        saveButton.configuration?.title = isSaved ? "Saved" : "Save"
        saveButton.tintColor = isSaved ? .reds : .black
    }
    
    private func openArticle(for news: News) {
        let articleViewController = ArticleViewController(news: news, allNews: [news] + viewModel.relatedNews)
        navigationController?.pushViewController(articleViewController, animated: true)
    }
    
    @objc private func backTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func saveTapped() {
        let isLoggedIn = UserDefaults.standard.bool(forKey: "IsLoggedIn")
        
        if isLoggedIn {
            viewModel.toggleSave()
            updateSaveButtonAppearance()
        } else {
            let promptViewController = SaveStoryPromptViewController()
            promptViewController.modalPresentationStyle = .overFullScreen 
            
            promptViewController.onSignInTapped = { [weak self] in
                let loginViewController = LoginViewController()
                loginViewController.hidesBottomBarWhenPushed = true
                self?.navigationController?.pushViewController(loginViewController, animated: true)
            }
            
            present(promptViewController, animated: true)
        }
    }
    @objc private func shareTapped() {
        let activityViewController = UIActivityViewController(
            activityItems: [viewModel.title],
            applicationActivities: nil
        )
        present(activityViewController, animated: true)
    }
}

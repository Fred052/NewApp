//
//  SearchViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 23.08.26.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private let viewModel = SearchViewModel()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Search"
        label.font = UIFont(name: "IowanOldStyle-Roman", size: 34) ?? .systemFont(ofSize: 34, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchFieldContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .secondarySystemBackground
        view.layer.cornerRadius = 14
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.clear.cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var searchIconImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "magnifyingglass"))
        imageView.tintColor = .systemGray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var searchTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search news, topics and stories"
        textField.font = .systemFont(ofSize: 16)
        textField.returnKeyType = .search
        textField.clearButtonMode = .never
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private lazy var clearFieldButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemGray3
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearFieldTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .onDrag
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var browseContentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var recentHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "RECENT SEARCHES"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var clearRecentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Clear", for: .normal)
        button.setTitleColor(.reds, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(clearRecentTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var recentStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var trendingHeaderLabel: UILabel = {
        let label = UILabel()
        label.text = "TRENDING TOPICS"
        label.font = .systemFont(ofSize: 12, weight: .bold)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var trendingStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var resultsCountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var resultsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        tableView.backgroundColor = .systemBackground
        tableView.isHidden = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupUI()
        setupResultsTableView()
        reloadBrowseContent()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupUI() {
        view.addSubview(titleLabel)
        view.addSubview(searchFieldContainer)
        view.addSubview(scrollView)
        view.addSubview(resultsTableView)
        
        searchFieldContainer.addSubview(searchIconImageView)
        searchFieldContainer.addSubview(searchTextField)
        searchFieldContainer.addSubview(clearFieldButton)
        
        scrollView.addSubview(browseContentView)
        
        browseContentView.addSubview(recentHeaderLabel)
        browseContentView.addSubview(clearRecentButton)
        browseContentView.addSubview(recentStackView)
        browseContentView.addSubview(trendingHeaderLabel)
        browseContentView.addSubview(trendingStackView)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            
            searchFieldContainer.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            searchFieldContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            searchFieldContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchFieldContainer.heightAnchor.constraint(equalToConstant: 50),
            
            searchIconImageView.leadingAnchor.constraint(equalTo: searchFieldContainer.leadingAnchor, constant: 16),
            searchIconImageView.centerYAnchor.constraint(equalTo: searchFieldContainer.centerYAnchor),
            searchIconImageView.widthAnchor.constraint(equalToConstant: 20),
            searchIconImageView.heightAnchor.constraint(equalToConstant: 20),
            
            searchTextField.leadingAnchor.constraint(equalTo: searchIconImageView.trailingAnchor, constant: 10),
            searchTextField.trailingAnchor.constraint(equalTo: clearFieldButton.leadingAnchor, constant: -8),
            searchTextField.centerYAnchor.constraint(equalTo: searchFieldContainer.centerYAnchor),
            
            clearFieldButton.trailingAnchor.constraint(equalTo: searchFieldContainer.trailingAnchor, constant: -14),
            clearFieldButton.centerYAnchor.constraint(equalTo: searchFieldContainer.centerYAnchor),
            clearFieldButton.widthAnchor.constraint(equalToConstant: 20),
            clearFieldButton.heightAnchor.constraint(equalToConstant: 20),
            
            scrollView.topAnchor.constraint(equalTo: searchFieldContainer.bottomAnchor, constant: 24),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            browseContentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            browseContentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            browseContentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            browseContentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            browseContentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            recentHeaderLabel.topAnchor.constraint(equalTo: browseContentView.topAnchor),
            recentHeaderLabel.leadingAnchor.constraint(equalTo: browseContentView.leadingAnchor, constant: 20),
            
            clearRecentButton.centerYAnchor.constraint(equalTo: recentHeaderLabel.centerYAnchor),
            clearRecentButton.trailingAnchor.constraint(equalTo: browseContentView.trailingAnchor, constant: -20),
            
            recentStackView.topAnchor.constraint(equalTo: recentHeaderLabel.bottomAnchor, constant: 12),
            recentStackView.leadingAnchor.constraint(equalTo: browseContentView.leadingAnchor, constant: 20),
            recentStackView.trailingAnchor.constraint(equalTo: browseContentView.trailingAnchor, constant: -20),
            
            trendingHeaderLabel.topAnchor.constraint(equalTo: recentStackView.bottomAnchor, constant: 28),
            trendingHeaderLabel.leadingAnchor.constraint(equalTo: browseContentView.leadingAnchor, constant: 20),
            
            trendingStackView.topAnchor.constraint(equalTo: trendingHeaderLabel.bottomAnchor, constant: 14),
            trendingStackView.leadingAnchor.constraint(equalTo: browseContentView.leadingAnchor, constant: 20),
            trendingStackView.trailingAnchor.constraint(equalTo: browseContentView.trailingAnchor, constant: -20),
            trendingStackView.bottomAnchor.constraint(equalTo: browseContentView.bottomAnchor, constant: -32),
            
            resultsTableView.topAnchor.constraint(equalTo: searchFieldContainer.bottomAnchor, constant: 12),
            resultsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            resultsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            resultsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupResultsTableView() {
        resultsTableView.delegate = self
        resultsTableView.dataSource = self
        resultsTableView.register(SearchResultTableViewCell.self, forCellReuseIdentifier: SearchResultTableViewCell.identifier)
        resultsTableView.tableHeaderView = makeResultsHeaderView()
    }
    
    private func makeResultsHeaderView() -> UIView {
        let container = UIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 36))
        
        resultsCountLabel.frame = CGRect(x: 20, y: 0, width: container.bounds.width - 40, height: 36)
        resultsCountLabel.autoresizingMask = [.flexibleWidth]
        container.addSubview(resultsCountLabel)
        
        return container
    }
    
    // MARK: - Browse content (recent + trending)
    
    private func reloadBrowseContent() {
        recentStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let recents = viewModel.recentSearches
        recentHeaderLabel.isHidden = recents.isEmpty
        clearRecentButton.isHidden = recents.isEmpty
        
        for term in recents {
            let row = RecentSearchRowView()
            row.configure(with: term)
            row.onTap = { [weak self] in
                self?.searchTextField.text = term
                self?.performSearch(with: term)
            }
            recentStackView.addArrangedSubview(row)
        }
        
        trendingStackView.arrangedSubviews.forEach { $0.removeFromSuperview() }
        
        let topics = viewModel.trendingTopics
        var index = 0
        while index < topics.count {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 12
            rowStack.distribution = .fillEqually
            
            let firstView = TrendingTopicView()
            firstView.configure(with: topics[index])
            firstView.onTap = { [weak self] in
                self?.searchTextField.text = topics[index].title
                self?.performSearch(with: topics[index].title)
            }
            rowStack.addArrangedSubview(firstView)
            
            if index + 1 < topics.count {
                let secondTopic = topics[index + 1]
                let secondView = TrendingTopicView()
                secondView.configure(with: secondTopic)
                secondView.onTap = { [weak self] in
                    self?.searchTextField.text = secondTopic.title
                    self?.performSearch(with: secondTopic.title)
                }
                rowStack.addArrangedSubview(secondView)
            } else {
                let spacer = UIView()
                rowStack.addArrangedSubview(spacer)
            }
            
            trendingStackView.addArrangedSubview(rowStack)
            index += 2
        }
    }
    
    // MARK: - Search flow
    
    private func performSearch(with query: String) {
        viewModel.updateQuery(query)
        viewModel.commitSearch()
        reloadBrowseContent()
        updateSearchState()
        searchTextField.resignFirstResponder()
    }
    
    private func updateSearchState() {
        let showingResults = viewModel.isShowingResults
        
        scrollView.isHidden = showingResults
        resultsTableView.isHidden = !showingResults
        clearFieldButton.isHidden = (searchTextField.text ?? "").isEmpty
        
        if showingResults {
            resultsCountLabel.text = viewModel.resultsCountText
            resultsTableView.tableHeaderView = makeResultsHeaderView()
            resultsTableView.reloadData()
        }
    }
    
    @objc private func textFieldChanged() {
        let text = searchTextField.text ?? ""
        viewModel.updateQuery(text)
        updateSearchState()
    }
    
    @objc private func clearFieldTapped() {
        searchTextField.text = ""
        viewModel.clearQuery()
        updateSearchState()
    }
    
    @objc private func clearRecentTapped() {
        viewModel.clearRecentSearches()
        reloadBrowseContent()
    }
}

// MARK: - UITextFieldDelegate

extension SearchViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        searchFieldContainer.layer.borderColor = UIColor.reds.cgColor
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        searchFieldContainer.layer.borderColor = UIColor.clear.cgColor
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        performSearch(with: textField.text ?? "")
        return true
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfResults()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: SearchResultTableViewCell.identifier,
            for: indexPath
        ) as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: viewModel.result(at: indexPath.row))
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        116
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let news = viewModel.result(at: indexPath.row)
        let articleViewController = ArticleViewController(news: news, allNews: viewModel.allNewsItems)
        navigationController?.pushViewController(articleViewController, animated: true)
    }
}

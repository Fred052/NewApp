//
//  HomeViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 15.08.26.
//

import UIKit

final class HomeViewController: UIViewController {

    private let viewModel = HomeViewModel()
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NEWS"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var profileButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "Profile1"), for: .normal)
        button.tintColor = .label
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemBackground
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTableView()
    }
    
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        headerView.addSubview(titleLabel)
        headerView.addSubview(searchButton)
        headerView.addSubview(profileButton)
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 60),
            
            titleLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            
            profileButton.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -20),
            profileButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            profileButton.widthAnchor.constraint(equalToConstant: 32),
            profileButton.heightAnchor.constraint(equalToConstant: 32),
            
            searchButton.trailingAnchor.constraint(equalTo: profileButton.leadingAnchor, constant: -16),
            searchButton.centerYAnchor.constraint(equalTo: headerView.centerYAnchor),
            searchButton.widthAnchor.constraint(equalToConstant: 24),
            searchButton.heightAnchor.constraint(equalToConstant: 24),
            
            
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(
            NewsTableViewCell.self,
            forCellReuseIdentifier: NewsTableViewCell.identifier
        )
    }
}


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 466
    }
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: NewsTableViewCell.identifier,
            for: indexPath
        ) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        
        let news = viewModel.item(at: indexPath.row)
        
        cell.configure(with: news)
        
        return cell
    }

}

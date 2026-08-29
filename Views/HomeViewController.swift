//
//  HomeViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 15.08.26.
//

import UIKit

final class HomeViewController: UIViewController {

    private let viewModel = HomeViewModel()
    
    private lazy var headerView: HeaderView = {
        let view = HeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        
        headerView.delegate = self
        
        headerView.configure(with: viewModel.categories)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
        
        view.addSubview(headerView)
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 90),
            
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
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
    
    private func presentSaveStoryPrompt() {
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


extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 466
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let news = viewModel.item(at: indexPath.row)
        let articleViewController = ArticleViewController(news: news, allNews: viewModel.allNewsItems)
        navigationController?.pushViewController(articleViewController, animated: true)
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
        let isLoggedIn = UserDefaults.standard.bool(forKey: "IsLoggedIn")
        let isSaved = isLoggedIn ? UserDefaultsSavedStore.shared.isSaved(news) : false
        
        cell.configure(with: news, isbookmarked: isSaved)
        
        cell.onbookmarkTapped = { [weak self, weak cell] in
            guard let self else { return }
            
            if isLoggedIn {
                UserDefaultsSavedStore.shared.toggle(news)
                let nowSaved = UserDefaultsSavedStore.shared.isSaved(news)
                cell?.setBookmarked(nowSaved)
            } else {
                self.presentSaveStoryPrompt()
            }
        }
        
        return cell
    }

}

extension HomeViewController: HeaderViewDelegate {
    func headerView(_ headerView: HeaderView, didSelect category: Category) {
        viewModel.filterNews(by: category)
        tableView.reloadData()
    }
}

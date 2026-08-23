//
//  OnboardingViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 15.08.26.
//

import UIKit

final class OnboardingViewController: UIViewController {
    
    private let viewModel = OnboardingViewModel()
    
    private lazy var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(OnboardingCell.self, forCellWithReuseIdentifier: OnboardingCell.identifier)
        
        return collectionView
    }()
    
    private let newsLabel: UILabel = {
        let label = UILabel()
        label.text = "NEWS"
        label.textColor = .white
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let skipButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.setTitle("Skip", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupAction()
        updateHeader()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        guard let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout else {
            return
        }
        
        layout.itemSize = collectionView.bounds.size
    }
    
    private func setupUI() {
        
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        view.addSubview(newsLabel)
        view.addSubview(skipButton)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            newsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
            newsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 28),
            
            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 14),
            skipButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -28)
        ])
        
        view.bringSubviewToFront(newsLabel)
        view.bringSubviewToFront(skipButton)
    }
    
    private func setupAction() {
        skipButton.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
    }
    
    @objc private func  skipTapped() {
        goToHome()
    }
    
    private func updateHeader() {
        skipButton.isHidden = viewModel.isLastPage
    }
    
    
    private func  continueButtonTapped() {
        
        if viewModel.isLastPage {
            
            goToHome()
            
            return
        }
        
        let moved = viewModel.moveToNextPage()
        
        guard moved else {
            return
        }
        
        let indexPath = IndexPath(item: viewModel.currentPage, section: 0)
        
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
        updateHeader()
    }
    
    func  scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.bounds.width)
        
        viewModel.moveToPage(page)
        
        updateHeader()
    }
    
    private func goToHome() {
        
        UserDefaults.standard.set(true, forKey: "HasSeenOnboarding")
        view.window?.rootViewController = MainTabBarController()
    }
}


extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCell.identifier, for: indexPath) as? OnboardingCell else {
            return UICollectionViewCell()
        }
        
        let page = viewModel.page(at: indexPath.item)
        
        let buttonTitle: String
        
        if indexPath.item == viewModel.numberOfPages - 1 {
            buttonTitle = "Get Started"
        } else {
            buttonTitle = "Continue"
        }
        
        cell.configure(with: page, buttonTitle: buttonTitle, currentPage: indexPath.item)
        
        cell.continueAction = { [weak self] in
            self?.continueButtonTapped()
        }
        
        return cell
    }
    
    
}

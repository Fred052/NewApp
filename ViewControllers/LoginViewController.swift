//
//  LoginViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 21.08.26.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let newsLabel: UILabel = {
        let newsLabel = UILabel()
        newsLabel.text = "N E W S"
        newsLabel.font = .systemFont(ofSize: 15, weight: .bold)
        newsLabel.translatesAutoresizingMaskIntoConstraints = false
        return newsLabel
    }()
    
    private lazy var closeButton: UIButton = {
        let closeButton = UIButton()
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(.muted, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 12)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        return closeButton
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.text = "Welcome back"
        titleLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 28) ?? .systemFont(ofSize: 46)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.75
        return titleLabel
    }()
    
    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Sign in to continue saving your favorite stories."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .muted
        return subtitleLabel
    }()
    
    private let emailTitleLabel: UILabel = {
        let emailTitleLabel = UILabel()
        emailTitleLabel.text = "E M A I L"
        emailTitleLabel.font = .systemFont(ofSize: 11.5, weight: .semibold)
        emailTitleLabel.textColor = .muted
        return emailTitleLabel
    }()
    
    private let emailTextField: UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "your@gmail.com"
        emailTextField.font = .systemFont(ofSize: 15)
        emailTextField.backgroundColor = .white
        emailTextField.layer.borderColor =  UIColor(white: 0.88, alpha: 1).cgColor
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.cornerRadius = 14
        emailTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        emailTextField.leftViewMode = .always
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        return emailTextField
    }()
    
    private let passwordTitleLabel: UILabel = {
        let passwordTitleLabel = UILabel()
        passwordTitleLabel.text = "P A S S W O R D"
        passwordTitleLabel.font = .systemFont(ofSize: 11.5, weight: .semibold)
        passwordTitleLabel.textColor = .muted
        return passwordTitleLabel
    }()
    
    private let passwordTextField: UITextField = {
        let passwordTextField = UITextField()
        passwordTextField.placeholder = "•••••••"
        passwordTextField.font = .systemFont(ofSize: 15)
        passwordTextField.backgroundColor = .white
        passwordTextField.layer.borderColor =  UIColor(white: 0.88, alpha: 1).cgColor
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.cornerRadius = 14
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        passwordTextField.leftViewMode = .always
        passwordTextField.isSecureTextEntry = true
        return passwordTextField
    }()
    
    private lazy var forgotPasswordButton: UIButton = {
        let forgotPasswordButton = UIButton()
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(.muted, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        forgotPasswordButton.contentHorizontalAlignment = .right
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return forgotPasswordButton
    }()
    
    private let signInButton = AppButton(title: "Sign In", style: .primary)
    private let leftLineView: UIView = {
        let leftLineView = UIView()
        leftLineView.backgroundColor = UIColor(white: 0.87, alpha: 1)
        return leftLineView
    }()
    
    private let orLabel: UILabel = {
        let orLabel = UILabel()
        orLabel.text = "or"
        orLabel.textColor = .muted
        orLabel.font = .systemFont(ofSize: 11)
        orLabel.textAlignment = .center
        return orLabel
    }()
    
    private let rightLineView: UIView = {
        let rightLineView = UIView()
        rightLineView.backgroundColor = UIColor(white: 0.87, alpha: 1)
        return rightLineView
    }()
    
    private let appleButton = AppButton(title: "Continue with Apple", style: .apple)
    private let accountLabel: UILabel = {
        let accountLabel = UILabel()
        accountLabel.text = "Don't have an acoount?"
        accountLabel.textColor = .muted
        accountLabel.font = .systemFont(ofSize: 13)
        return accountLabel
    }()
    
    private lazy var createAccountButton: UIButton = {
        let createAccountButton = UIButton()
        createAccountButton.setTitle("Create one", for: .normal)
        createAccountButton.setTitleColor(.reds, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        return createAccountButton
    }()
    
    private let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1)
        view.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        
        setupUI()
        setupConstraints()
        bindViewModel()
    }
    
    private func setupUI() {
        [newsLabel, closeButton, titleLabel, subtitleLabel, emailTitleLabel, emailTextField, passwordTitleLabel, passwordTextField, forgotPasswordButton, signInButton, leftLineView, orLabel, rightLineView, appleButton, accountLabel, createAccountButton].forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        setupButtons()
    }
    
    private func setupButtons() {
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        appleButton.addTarget(self, action: #selector(appleTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        let safeArea = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            newsLabel.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            newsLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            
            closeButton.centerYAnchor.constraint(equalTo: newsLabel.centerYAnchor),
            closeButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: newsLabel.bottomAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            emailTitleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 36),
            emailTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emailTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTitleLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            passwordTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            passwordTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTitleLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: emailTextField.heightAnchor),
            
            forgotPasswordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            forgotPasswordButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            forgotPasswordButton.widthAnchor.constraint(equalToConstant: 170),
            forgotPasswordButton.heightAnchor.constraint(equalToConstant: 26),
            
            signInButton.topAnchor.constraint(equalTo: forgotPasswordButton.bottomAnchor, constant: 15),
            signInButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            signInButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            signInButton.heightAnchor.constraint(equalToConstant: 52),
            
            orLabel.topAnchor.constraint(equalTo: signInButton.bottomAnchor, constant: 15),
            orLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orLabel.widthAnchor.constraint(equalToConstant: 28),
            
            leftLineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            leftLineView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            leftLineView.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -14),
            leftLineView.heightAnchor.constraint(equalToConstant: 1),
            
            rightLineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            rightLineView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            rightLineView.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 14),
            rightLineView.heightAnchor.constraint(equalToConstant: 1),
            
            appleButton.topAnchor.constraint(equalTo: orLabel.bottomAnchor, constant: 15),
            appleButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            appleButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            appleButton.heightAnchor.constraint(equalTo: signInButton.heightAnchor),
            
            accountLabel.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
            accountLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: -42),
            
            createAccountButton.centerYAnchor.constraint(equalTo: accountLabel.centerYAnchor),
            createAccountButton.leadingAnchor.constraint(equalTo: accountLabel.trailingAnchor, constant: 4)
            
        ])
    }
    
    private func bindViewModel() {
        viewModel.onMessageChanged = { [weak self] message in
            DispatchQueue.main.async {
                self?.showMessage(message)
            }
        }
        
        viewModel.onLoginSuccess = { [weak self] in
            DispatchQueue.main.async {
                self?.goToHome()
            }
            
        }
    }
    
    private func goToHome() {
        let homeVC = HomeViewController()
        navigationController?.setViewControllers([homeVC], animated: true)
    }
    
    private func showMessage(_ message: String) {
        let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func closeTapped() {
        guard let navigationController = navigationController else {
            dismiss(animated: true)
            return
        }
        
        let homeViewController = HomeViewController()
        navigationController.setViewControllers([homeViewController], animated: true)
    }
    
    @objc private func forgotPasswordTapped() {
        viewModel.onMessageChanged?("You will be redirected to the password reset screen.")
    }
    
    @objc private func signInTapped() {
        print("SIGN IN BUTTON TAPPED")
        
        viewModel.login(
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "")
    }
    
    @objc private func appleTapped() {
        viewModel.continueWithApple()
    }
    
    @objc private func createAccountTapped() {
        let registrationViewController = RegistrationViewController()
        navigationController?.pushViewController(registrationViewController, animated: true)
    }
}

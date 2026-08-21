//
//  LoginViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 21.08.26.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let viewModel = LoginViewModel()
    
    private let mutedColor = UIColor(red: 0.58, green: 0.55, blue: 0.53, alpha: 1)
    private let redColor = UIColor(red: 0.72, green: 0.11, blue: 0.14, alpha: 1)
    private let textColor = UIColor(red: 18 / 255, green: 16 / 255, blue: 15 / 255, alpha: 1)
    
    private let newsLabel = UILabel()
    private let closeButton = UIButton()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let emailTitleLabel = UILabel()
    private let emailTextField = UITextField()
    private let passwordTitleLabel = UILabel()
    private let passwordTextField = UITextField()
    private let forgotPasswordButton = UIButton(type: .system)
    private let signInButton = AppButton(title: "Sign In", style: .primary)
    private let lefLineView = UIView()
    private let orLabel = UILabel()
    private let rigtLineView = UIView()
    private let appleButton = AppButton(title: "Continue with Apple", style: .apple)
    private let accountLabel = UILabel()
    private let createAccountButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1)
        view.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        [newsLabel, closeButton, titleLabel, subtitleLabel, emailTitleLabel, emailTextField, passwordTitleLabel, passwordTextField, forgotPasswordButton, signInButton, lefLineView, orLabel, rigtLineView, appleButton, accountLabel, createAccountButton].forEach { item in
            view.addSubview(item)
            item.translatesAutoresizingMaskIntoConstraints = false
            
        }
        
        setupHeader()
        setupForm()
        setupButtons()
        setupDivider()
        setupFooter()
    }
    
    
    private func setupHeader() {
        newsLabel.text = "N E W S"
        newsLabel.font = .systemFont(ofSize: 15, weight: .bold)
        
        closeButton.setTitle("Close", for: .normal)
        closeButton.setTitleColor(mutedColor, for: .normal)
        closeButton.titleLabel?.font = .systemFont(ofSize: 12)
        closeButton.addTarget(self, action: #selector(closeTapped), for: .touchUpInside)
        
        titleLabel.text = "Welcome back"
        titleLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 28) ?? .systemFont(ofSize: 46)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.75
        
        subtitleLabel.text = "Sign in to continue saving your favorite stories."
        subtitleLabel.numberOfLines = 0
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = mutedColor
    }
    
    private func setupForm() {
        
        configureTitleLabel(emailTitleLabel, text: "E M A I L")
        configureTextField(emailTextField, placeHolder: "your@gmail.com")
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        
        configureTitleLabel(passwordTitleLabel, text: "P A S S W O R D")
        configureTextField(passwordTextField, placeHolder: "•••••••")
        passwordTextField.isSecureTextEntry = true
        
        forgotPasswordButton.setTitle("Forgot Password?", for: .normal)
        forgotPasswordButton.setTitleColor(redColor, for: .normal)
        forgotPasswordButton.titleLabel?.font = .systemFont(ofSize: 12, weight: .medium)
        forgotPasswordButton.contentHorizontalAlignment = .right
        forgotPasswordButton.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
    }
    
    private func configureTitleLabel(_ label: UILabel, text: String) {
        label.text = text
        label.font = .systemFont(ofSize: 11.5, weight: .semibold)
        label.textColor = mutedColor
    }
    
    private func configureTextField(_ textField: UITextField, placeHolder: String) {
        textField.placeholder = placeHolder
        textField.font = .systemFont(ofSize: 15)
        textField.backgroundColor = .white
        textField.layer.borderColor =  UIColor(white: 0.88, alpha: 1).cgColor
        textField.layer.borderWidth = 1.5
        textField.layer.cornerRadius = 14
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 15, height: 1))
        textField.leftViewMode = .always
    }
    
    private func setupButtons() {
        signInButton.addTarget(self, action: #selector(signInTapped), for: .touchUpInside)
        
        appleButton.addTarget(self, action: #selector(appleTapped), for: .touchUpInside)
    }
    
    private func setupDivider() {
        lefLineView.backgroundColor = UIColor(white: 0.87, alpha: 1)
        rigtLineView.backgroundColor = UIColor(white: 0.87, alpha: 1)
        orLabel.text = "or"
        orLabel.textColor = mutedColor
        orLabel.font = .systemFont(ofSize: 11)
        orLabel.textAlignment = .center
    }
    
    private func setupFooter() {
        accountLabel.text = "Don't have an acoount?"
        accountLabel.textColor = mutedColor
        accountLabel.font = .systemFont(ofSize: 13)
        
        createAccountButton.setTitle("Create one", for: .normal)
        createAccountButton.setTitleColor(redColor, for: .normal)
        createAccountButton.titleLabel?.font = .systemFont(ofSize: 13, weight: .semibold)
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
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
            
            lefLineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            lefLineView.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            lefLineView.trailingAnchor.constraint(equalTo: orLabel.leadingAnchor, constant: -14),
            lefLineView.heightAnchor.constraint(equalToConstant: 1),
            
            rigtLineView.centerYAnchor.constraint(equalTo: orLabel.centerYAnchor),
            rigtLineView.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            rigtLineView.leadingAnchor.constraint(equalTo: orLabel.trailingAnchor, constant: 14),
            rigtLineView.heightAnchor.constraint(equalToConstant: 1),
            
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
        viewModel.onMessageChanged = {[weak self] message in
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    @objc private func closeTapped() {
        dismiss(animated: true)
    }
    
    @objc private func forgotPasswordTapped() {
        viewModel.onMessageChanged?("You will be redirected to the password reset screen.")
    }
    
    @objc private func signInTapped() {
        let login = Login(email: emailTextField.text ?? "", password: passwordTextField.text ?? "")
        viewModel.signIn(with: login)
    }
    
    @objc private func appleTapped() {
        viewModel.continueWithApple()
    }
    
    @objc private func createAccountTapped() {
        
        let registrationViewController = RegistrationViewController()
            navigationController?.pushViewController(registrationViewController, animated: true)
    }
}

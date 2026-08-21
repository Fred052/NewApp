//
//  RegistrationViewController.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 20.08.26.
//

import UIKit

final class RegistrationViewController: UIViewController {
    private let viewModel = RegistrationViewModel()
    
    private let mutedColor = UIColor(red: 0.58, green: 0.55, blue: 0.53, alpha: 1)
    private let redColor = UIColor(red: 0.72, green: 0.11, blue: 0.14, alpha: 1)
    
    private let backButton = UIButton(type: .system)
    private let newsLabel = UILabel()
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    
    private let nameTitleLabel = UILabel()
    private let nameTextField = UITextField()
    
    private let emailTitleLabel = UILabel()
    private let emailTextField = UITextField()
    
    
    private let passwordTitleLabel = UILabel()
    private let passwordTextField = UITextField()
    
    private let confirmPasswordTitleLabel = UILabel()
    private let confirmPasswordTextField = UITextField()
    
    private let createAccountButton = AppButton(title: "Create Account", style: .primary )
    private let appleButton = AppButton(title: "Continue with Apple", style: .apple)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.98, green: 0.97, blue: 0.96, alpha: 1)
        view.layoutMargins = UIEdgeInsets(top: 0, left: 22, bottom: 0, right: 22)
        
        setupUI()
        setupConstraints()
    }
    
    
    private func setupUI() {
        [backButton, newsLabel, titleLabel, subtitleLabel, nameTitleLabel, nameTextField, emailTitleLabel, emailTextField, passwordTitleLabel, passwordTextField, confirmPasswordTitleLabel, confirmPasswordTextField, createAccountButton, appleButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        setupHeader()
        setupForm()
        setupButtons()
        
    }
    
    
    private func setupHeader() {
        var backConfiguration = UIButton.Configuration.plain()
        backConfiguration.image = UIImage(systemName: "chevron.left")
        backConfiguration.title = "Back"
        backConfiguration.imagePadding = 8
        backConfiguration.baseForegroundColor = .black
        backButton.configuration = backConfiguration
        backButton.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
        
        newsLabel.text = "N E W S"
        newsLabel.font = .systemFont(ofSize: 15, weight: .bold)
        newsLabel.textAlignment = .right
        
        titleLabel.text = "Create your Account"
        titleLabel.font = UIFont(name: "IowanOldStyle-Roman", size: 32) ?? .systemFont(ofSize: 46)
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.minimumScaleFactor = 0.75
        
        subtitleLabel.text = "Save stories and build your personal news\nlibrary."
        subtitleLabel.numberOfLines = 2
        subtitleLabel.font = .systemFont(ofSize: 16)
        subtitleLabel.textColor = mutedColor
    }
    
    private func setupForm() {
        configureTitleLabel(nameTitleLabel, text: "N A M E")
        configureTextField(nameTextField, placeHolder: "Fred")
        
        configureTitleLabel(emailTitleLabel, text: "E M A I L")
        configureTextField(emailTextField, placeHolder: "your@gmail.com")
        emailTextField.keyboardType = .emailAddress
        emailTextField.autocapitalizationType = .none
        
        configureTitleLabel(passwordTitleLabel, text: "P A S S W O R D")
        configureTextField(passwordTextField, placeHolder: "At least 8 characters")
        passwordTextField.isSecureTextEntry = true
        
        configureTitleLabel(confirmPasswordTitleLabel, text: "C O N F I R M  P A S S W O R D")
        configureTextField(confirmPasswordTextField, placeHolder: "Repeat Password")
        confirmPasswordTextField.isSecureTextEntry = true
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
        createAccountButton.addTarget(self, action: #selector(createAccountTapped), for: .touchUpInside)
        appleButton.addTarget(self, action: #selector(appleTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        
        let safeArea = view.safeAreaLayoutGuide
        let margins = view.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            
            backButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 10),
            backButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 13),
            
            newsLabel.centerYAnchor.constraint(equalTo: backButton.centerYAnchor),
            newsLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 44),
            titleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 14),
            subtitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            
            nameTitleLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 30),
            nameTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            nameTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            nameTextField.topAnchor.constraint(equalTo: nameTitleLabel.bottomAnchor, constant: 8),
            nameTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            nameTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            nameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            emailTitleLabel.topAnchor.constraint(equalTo: nameTextField.bottomAnchor, constant: 8),
            emailTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emailTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            emailTextField.topAnchor.constraint(equalTo: emailTitleLabel.bottomAnchor, constant: 8),
            emailTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            emailTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            emailTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            passwordTitleLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 8),
            passwordTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            passwordTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordTitleLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            passwordTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            passwordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            confirmPasswordTitleLabel.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 8),
            confirmPasswordTitleLabel.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            confirmPasswordTitleLabel.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            
            confirmPasswordTextField.topAnchor.constraint(equalTo: confirmPasswordTitleLabel.bottomAnchor, constant: 8),
            confirmPasswordTextField.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            confirmPasswordTextField.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            confirmPasswordTextField.heightAnchor.constraint(equalTo: nameTextField.heightAnchor),
            
            createAccountButton.topAnchor.constraint(equalTo: confirmPasswordTextField.bottomAnchor, constant: 16),
            createAccountButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            createAccountButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            createAccountButton.heightAnchor.constraint(equalToConstant: 54),
            
            appleButton.topAnchor.constraint(equalTo: createAccountButton.bottomAnchor, constant: 12),
            appleButton.leadingAnchor.constraint(equalTo: margins.leadingAnchor),
            appleButton.trailingAnchor.constraint(equalTo: margins.trailingAnchor),
            appleButton.heightAnchor.constraint(equalTo: createAccountButton.heightAnchor)
            
        ])
    }
    
    private func bindViewModel() {
        viewModel.onMessageChanged = {[weak self] message in
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default))
            self?.present(alert, animated: true)
        }
    }
    
    
    @objc private func backTapped() {
        if let navigationController,
           navigationController.viewControllers.count > 1 {
            navigationController.popViewController(animated: true)
        } else {
            dismiss(animated: true)
        }
    }
    
    
    @objc private func createAccountTapped() {
        let registration = Registration(
            name: nameTextField.text ?? "",
            email: emailTextField.text ?? "",
            password: passwordTextField.text ?? "",
            confirmPassword: confirmPasswordTextField.text ?? "")
        
        viewModel.createAccount(with: registration)
    }
    
    @objc private func appleTapped() {
        viewModel.continueWithApple()
    }
    
}

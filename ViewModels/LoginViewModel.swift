//
//  LoginViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 21.08.26.
//

import Foundation

final class LoginViewModel {
    
    var onMessageChanged: ((String) -> Void)?
    
    func signIn(with login: Login) {
        guard login.email.contains("@") else {
            onMessageChanged?("Enter a valid email address.")
            
            return
        }
        
        guard !login.password.isEmpty else {
            onMessageChanged?("Please enter your password")
            
            return
        }
        
        onMessageChanged?("Login successful")
    }
    
    func continueWithApple() {
        onMessageChanged?("The decision was made to continue with Apple.")
    }
}

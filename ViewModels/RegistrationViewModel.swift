//
//  RegistrationViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 20.08.26.
//

import Foundation

final class RegistrationViewModel {
    
    var onMessageChanged: ((String) -> Void)?
    
    
    func createAccount(with registration: Registration) {
        guard !registration.name.trimmingCharacters(in:
                .whitespacesAndNewlines).isEmpty else {
            onMessageChanged?("Please write your Name.")
            
            return
        }
        
        guard registration.email.contains("@") else {
            onMessageChanged?("Enter a valid email address.")
            
            return
        }
        
        guard registration.password.count >= 8 else {
            onMessageChanged?("The password must be at least 8 characters long.")
            
            return
        }
        
        guard registration.password == registration.confirmPassword else {
            onMessageChanged?("The passwords don't match.")
            
            return
        }
        
        onMessageChanged?("Your account has been successfully created.")
    }
    
    func continueWithApple() {
        onMessageChanged?("The choice was to continue with Apple.")
    }
}

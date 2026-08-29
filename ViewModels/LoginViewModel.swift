//
//  LoginViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 21.08.26.
//

import Foundation
import CoreData

final class LoginViewModel {
    var onMessageChanged: ((String) -> Void)?
    var onLoginSuccess: (() -> Void)?
    
    func login(email: String, password: String) {
        
        let cleanEmail = email
            .trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        
        guard !cleanEmail.isEmpty else {
            onMessageChanged?("Please enter your email.")
            
            return
        }
        
        guard cleanEmail.contains("@") else {
            onMessageChanged?("Enter a valid email address.")
            
            return
        }
        
        guard !password.isEmpty else {
            onMessageChanged?("Please enter your password")
            
            return
        }
        
        let context = CoreDataManager.shared.context
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "email ==[c] %@ AND password == %@", cleanEmail, password)
        
        do {
            let users = try context.fetch(request)
            
            if let loggedInUser = users.first {
                UserDefaults.standard.set(true, forKey: "IsLoggedIn")
                UserDefaults.standard.set(loggedInUser.email, forKey: "LoggedInUserEmail")
                onLoginSuccess?()
            } else {
                onMessageChanged?("Email or password is incorrect.")
            }
        } catch {
            print("Failed to fetch user: \(error)")
            onMessageChanged?("Something went wrong. Please try again.")
        }
    }
    
    func continueWithApple() {
        onMessageChanged?("The choice was to continue with Apple.")
    }
}

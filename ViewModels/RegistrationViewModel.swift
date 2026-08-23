//
//  RegistrationViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 20.08.26.
//

import Foundation
import CoreData

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
        
        // Check Existing User
        guard !userExists(email: registration.email) else {
            onMessageChanged?("An account with this email already exists.")
            
            return
        }
        
        // Create User
        let context = CoreDataManager.shared.context
        
        let user = User(context: context)
        
        user.id = UUID()
        user.name = registration.name
            .trimmingCharacters(in: .whitespacesAndNewlines)
        user.email = registration.email
            .trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        user.password = registration.password
        
        // Save User
        do {
            try context.save()
            onMessageChanged?("Your account has been successfully created.")
        } catch {
            print("Failed to save user: \(error)")
            onMessageChanged?("Something went wrong. Please try again.")
        }
    }
    
    private func userExists(email: String) -> Bool {
        let context = CoreDataManager.shared.context
        
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "email ==[c] %@", email.trimmingCharacters(in: .whitespacesAndNewlines))
        
        do {
            let users = try context.fetch(request)
            return !users.isEmpty
        } catch {
            print("Failed to fetch user: \(error)")
            return false
        }
    }
    
    func continueWithApple() {
        onMessageChanged?("The choice was to continue with Apple.")
    }
}

//
//  LoggedInProfileViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 24.08.26.
//
import Foundation
import CoreData

final class LoggedInProfileViewModel {
    
    var fullName: String {
        currentUser?.name ?? "—"
    }
    
    var email: String {
        currentUser?.email ?? "—"
    }
    
    var savedStoryCount: String {
        "\(UserDefaultsSavedStore.shared.fetchAll().count)"
    }
    
    private var currentUser: User? {
        guard let email = UserDefaults.standard.string(forKey: "LoggedInUserEmail") else {
            return nil
        }
        
        let context = CoreDataManager.shared.context
        let request = User.fetchRequest()
        request.predicate = NSPredicate(format: "email ==[c] %@", email)
        request.fetchLimit = 1
        
        do {
            return try context.fetch(request).first
        } catch {
            print("Failed to fetch logged-in user: \(error)")
            return nil
        }
    }
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
        UserDefaults.standard.removeObject(forKey: "LoggedInUserEmail")
    }
}


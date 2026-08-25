//
//  LoggedInProfileViewModel.swift
//  NewApp
//
//  Created by Ferid Suleymanzade on 24.08.26.
//

import Foundation

final class LoggedInProfileViewModel {
    
    let fullName = "Fred"
    let email = "fred01@gmail.com"
    let savedStoryCount = "3"
    
    func logOut() {
        UserDefaults.standard.set(false, forKey: "IsLoggedIn")
    }
}


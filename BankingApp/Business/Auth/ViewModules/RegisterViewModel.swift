//
//  RegisterViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation
import RealmSwift

protocol RegisterViewModelDelegate: AnyObject {
    func usernameError()
    func passwordError()
    func emailError()
    func usernameValid()
    func passwordValid()
    func emailValid()
}

final class RegisterViewModel {
    
    let realm = try! Realm()
    weak var delegate: RegisterViewModelDelegate?
    
    var username = ""
    var password = ""
    var email = ""
    
    func setInput(username: String, password: String, email: String) {
        self.username = username
        self.password = password
        self.email = email
    }
    
    func isUserInputValid() -> Bool {
        
        if !username.isUsernameValid() {
            delegate?.usernameError()
        } else {
            delegate?.usernameValid()
        }
        if !password.isPasswordValid() {
            delegate?.passwordError()
        } else {
            delegate?.passwordValid()
        }
        if !email.isValidEmail() {
            delegate?.emailError()
        } else {
            delegate?.emailValid()
        }
        return (username.isUsernameValid() && password.isPasswordValid() && email.isValidEmail())
    }
    
    func saveUser() {
        let user = User()
        user.username = username
        user.email = email
        user.password = password
        
        try? realm.write {
            realm.add(user)
        }
    }
}

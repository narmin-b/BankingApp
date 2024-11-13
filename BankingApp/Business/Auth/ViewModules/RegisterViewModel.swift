//
//  RegisterViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation
import RealmSwift

protocol RegisterViewModelDelegate: AnyObject {
    func fullnameError()
    func usernameError()
    func passwordError()
    func emailError()
    func fullnameValid()
    func usernameValid()
    func passwordValid()
    func emailValid()
}

final class RegisterViewModel {
    
    let realm = try! Realm()
    weak var delegate: RegisterViewModelDelegate?
    
    var fullname = ""
    var username = ""
    var password = ""
    var email = ""
    
    func setInput(fullname: String, username: String, password: String, email: String) {
        self.fullname = fullname
        self.username = username
        self.password = password
        self.email = email
    }
    
    func isUserInputValid() -> Bool {
        
        if !fullname.isFullNameValid() {
            delegate?.fullnameError()
        } else {
            delegate?.fullnameValid()
        }
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
        return (fullname.isFullNameValid() && username.isUsernameValid() && password.isPasswordValid() && email.isValidEmail())
    }
    
    func saveUser() {
        let user = User()
        user.fullName = fullname
        user.username = username
        user.email = email
        user.password = password
        
        try? realm.write {
            realm.add(user)
        }
    }
}

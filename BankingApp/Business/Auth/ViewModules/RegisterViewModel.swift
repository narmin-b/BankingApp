//
//  RegisterViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation
import RealmSwift

protocol RegisterViewModelDelegate: AnyObject {
    func firstnameError()
    func lastnameError()
    func usernameError()
    func passwordError()
    func emailError()
    func firstnameValid()
    func lastnameValid()
    func usernameValid()
    func passwordValid()
    func emailValid()
}

final class RegisterViewModel {
    
    let realm = try! Realm()
    weak var delegate: RegisterViewModelDelegate?
    
    var firstName = ""
    var lastName = ""
    var username = ""
    var password = ""
    var email = ""
    
    func setInput(firstName: String, lastName: String, username: String, password: String, email: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.username = username
        self.password = password
        self.email = email
    }
    
    func isUserInputValid() -> Bool {
        
        if !firstName.isFullNameValid() {
            delegate?.firstnameError()
        } else {
            delegate?.firstnameValid()
        }
        if !lastName.isFullNameValid() {
            delegate?.lastnameError()
        } else {
            delegate?.lastnameValid()
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
        return (firstName.isFullNameValid() && lastName.isFullNameValid() && username.isUsernameValid() && password.isPasswordValid() && email.isValidEmail())
    }
    
    func saveUser() {
        let user = User()
        user.firstName = firstName
        user.lastName = lastName
        user.username = username
        user.email = email
        user.password = password
        
        try? realm.write {
            realm.add(user)
        }
    }
}

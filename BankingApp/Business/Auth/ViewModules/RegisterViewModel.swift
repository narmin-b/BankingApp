//
//  RegisterViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation
import RealmSwift

protocol RegisterViewModelDelegate: AnyObject {
    func fieldError(_ type: ValidationType)
    func fieldValid(_ type: ValidationType)
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
    
    func isValid(value: String, type: ValidationType) -> Bool {
        switch type {
        case .firstName, .lastName:
            return value.isFullNameValid()
        case .username:
            return value.isUsernameValid()
        case .email:
            return value.isValidEmail()
        case .password:
            return value.isPasswordValid()
        }
    }
    
    func isAllInputValid() -> Bool {
        var flag = true
        let validations: [ValidationType : Bool] = [.firstName : isValid(value: firstName, type: .firstName),
                                                    .lastName : isValid(value: lastName, type: .lastName),
                                                    .username : isValid(value: username, type: .username),
                                                    .email : isValid(value: email, type: .email),
                                                    .password : isValid(value: password, type: .password)]
        for (key, value) in validations {
            if value == false {
                delegate?.fieldError(key)
                flag = false
            } else {
                delegate?.fieldValid(key)
            }
        }
        return flag
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

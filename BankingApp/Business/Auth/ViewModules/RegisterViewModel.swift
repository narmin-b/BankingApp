//
//  RegisterViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation

protocol RegisterViewModelDelegate: AnyObject {
    func fieldError(_ type: ValidationType)
    func fieldValid(_ type: ValidationType)
}

final class RegisterViewModel {
    
    weak var delegate: RegisterViewModelDelegate?
    
    private var firstName = ""
    private var lastName = ""
    private var username = ""
    private var password = ""
    private var email = ""
    
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
        
        RealmHelper.addObject(user)
    }
}

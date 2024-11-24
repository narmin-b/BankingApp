//
//  RegisterViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation

final class RegisterViewModel {
    enum ViewState {
        case error(message: String)
        case fieldError(_ type: ValidationType)
        case fieldValid(_ type: ValidationType)
    }
    
    var listener: ((ViewState) -> Void)?
    
    private var model: UserDataModel = UserDataModel()

    
    func setInput(firstName: String, lastName: String, username: String, password: String, email: String) {
        model.firstName = firstName
        model.lastName = lastName
        model.username = username
        model.password = password
        model.email = email
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
        let validations: [ValidationType : Bool] = [.firstName : isValid(value: model.firstName ?? "", type: .firstName),
                                                    .lastName : isValid(value: model.lastName ?? "", type: .lastName),
                                                    .username : isValid(value: model.username, type: .username),
                                                    .email : isValid(value: model.email ?? "", type: .email),
                                                    .password : isValid(value: model.password, type: .password)]
        for (key, value) in validations {
            if value == false {
                listener?(.fieldError(key))
                flag = false
            } else {
                listener?(.fieldValid(key))
            }
        }
        return flag
    }
    
    func saveUser() {
        let user = User()
        user.mapFrom(from: model)
        RealmHelper.addObject(user)
    }
}

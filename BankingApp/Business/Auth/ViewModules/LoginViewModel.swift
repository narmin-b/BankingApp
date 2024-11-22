//
//  LoginViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation
import RealmSwift

protocol LoginViewModelDelegate: AnyObject {
    func userError()
    func passwordError()
}

final class LoginViewModel {
    enum ViewState {
        case error(String)
        case userError
        case passwordError
        case success
    }
    
    var listener: ((ViewState) -> Void)?
    weak var delegate: LoginViewModelDelegate?
    
    private var username = ""
    private var password = ""
    private var firstName: String = ""
    private var lastName: String = ""
    
    func setInput(username: String, password: String) {
        self.username = username
        self.password = password
    }

    func isUserValid() -> Bool {
        if let user = RealmHelper.fetchObjects(User.self).filter({$0.username == self.username}).first {
            if user.password == password {
                firstName = user.firstName
                lastName = user.lastName
                saveLoggedUser(id: user._id)
                return true
            }
            else {
                delegate?.passwordError()
                return false
            }
        }
        else {
            delegate?.userError()
            return false
        }
    }
    
    func saveLoggedUser(id: ObjectId) {
        let strID = id.stringValue
        UserDefaults.standard.set(strID, forKey: "userID")
    }
}

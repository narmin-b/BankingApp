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
    
    let realm = try! Realm()
    weak var delegate: LoginViewModelDelegate?
    
    var username = ""
    var password = ""
    var firstName: String = ""
    var lastName: String = ""
    
    func setInput(username: String, password: String) {
        self.username = username
        self.password = password
    }

    func isUserValid() -> Bool {
        if let user = realm.objects(User.self).filter({$0.username == self.username}).first {
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

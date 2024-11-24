//
//  LoginViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import Foundation
import RealmSwift

final class LoginViewModel {
    enum ViewState {
        case error(String)
        case userError
        case passwordError
        case success
    }
    
    var listener: ((ViewState) -> Void)?
    
    private var model: UserDataModel = UserDataModel()
    
    func setInput(username: String, password: String) {
        model.username = username
        model.password = password
    }

    func isUserValid() -> Bool {
        if let user = RealmHelper.fetchObjects(User.self).filter({$0.username == self.model.username}).first {
            if user.password == model.password {
                model.firstName = user.firstName
                model.lastName = user.lastName
                saveLoggedUser(id: user._id)
                listener?(.success)
                return true
            }
            else {
                listener?(.passwordError)
                listener?(.error("Wrong Password"))
                return false
            }
        }
        else {
            listener?(.userError)
            listener?(.error("User does not exist"))
            return false
        }
    }
    
    func saveLoggedUser(id: ObjectId) {
        let strID = id.stringValue
        UserDefaults.standard.set(strID, forKey: "userID")
    }
}

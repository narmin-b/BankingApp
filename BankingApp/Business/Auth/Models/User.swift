//
//  User.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import Foundation
import RealmSwift

class User: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var firstName: String!
    @Persisted var lastName: String!
    @Persisted var username: String!
    @Persisted var password: String?
    @Persisted var email: String?
}

extension User {
    func mapFrom(from model: UserDataModel){
        self.firstName = model.firstName
        self.lastName = model.lastName
        self.username = model.username
        self.password = model.password
        self.email = model.email
    }
}

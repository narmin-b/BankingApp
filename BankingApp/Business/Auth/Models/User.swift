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
    @Persisted var fullName: String!
    @Persisted var username: String!
    @Persisted var password: String?
    @Persisted var email: String?
}

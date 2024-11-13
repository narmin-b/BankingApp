//
//  Card.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 13.11.24.
//

import Foundation
import RealmSwift

class Card: Object {
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var cardNo: Int!
    @Persisted var pin: Int!
    @Persisted var balance: Double!
    @Persisted var owner: User!
}

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
    @Persisted var owner: User!
    @Persisted var cardType: String!
    @Persisted var cardNo: Int!
    @Persisted var pin: Int!
    @Persisted var balance: Double!
}

extension Card {
    func cardInfo() -> String {
        return "\(self.cardType.capitalized) ****\(String(self.cardNo ?? 0).suffix(4)) - \(self.balance ?? 0) ₼"
    }
}

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
        let newBalance = (self.balance).rounded()
        let doubleStr = Double(String(format: "%.2f", self.balance))
        
        return "\(self.cardType.capitalized) ****\(String(self.cardNo ?? 0).suffix(4)) - \(doubleStr ?? 0) ₼"
    }
    
    func mapFrom(from model: CardDataModel){
        self.owner = model.owner
        self.cardType = model.cardType
        self.cardNo = model.cardNo
        self.pin = model.pin
        self.balance = model.balance
    }
}

//
//  AddCardViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 28.11.24.
//

import Foundation

enum CardValidations: CaseIterable {
    case cardType, cardNo, pin, balance
}

final class AddCardViewModel {
    enum ViewState {
        case error(message: String)
        case success
        case fieldError(_ type: CardValidations)
        case fieldValid(_ type: CardValidations)
    }
    
    enum CardType: String, CaseIterable {
        case visa = "Visa"
        case mastercard = "Mastercard"
    }
    
    var listener: ((ViewState) -> Void)?
    private var card: CardDataModel = CardDataModel(owner: User(), cardType: "", cardNo: 0, pin: 0, balance: 0)
    private var cardTypes: [String] = []
    
    func setInput(cardType: String, cardNo: String, pin: String, balance: String) {
        card.cardType = cardType
        card.cardNo = cardNo.strToInt()
        card.pin = pin.strToInt()
        card.balance = balance.strToDouble()
    }
    
    fileprivate func isValid(value: Any, type: CardValidations) -> Bool {
        switch type {
        case .cardType:
            return !card.cardType.isEmpty
        case .cardNo:
            return card.cardNo.isCardNoValid()
        case .pin:
            return card.pin.isPinValid()
        case .balance:
            return card.balance.isBalanceValid()
        }
    }
    
    func checkEmptyFields() {
        for validation in CardValidations.allCases {
            switch validation {
            case .cardType:
                if card.cardType == nil {
                    card.cardType = ""
                }
            case .cardNo:
                if card.cardNo == nil {
                    card.cardNo = 0
                }
            case .pin:
                if card.pin == nil {
                    card.pin = 0
                }
            case .balance:
                if card.balance == nil {
                    card.balance = -1
                }
            }
        }
    }
    
    func isAllInputValid() -> Bool {
        var flag = true
        checkEmptyFields()
        let validations: [CardValidations : Bool] = [.cardType : isValid(value: card.cardType ?? "", type: .cardType),
                                                     .cardNo : isValid(value: card.cardNo ?? 0, type: .cardNo),
                                                     .pin : isValid(value: card.pin ?? 0, type: .pin),
                                                     .balance : isValid(value: card.balance ?? 0, type: .balance)]
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
    
    func addCard() {
        let user = UserDefaults.standard.string(forKey: "userID")?.userForIDstring()
        card.owner = user
        let newCard = Card()
        newCard.mapFrom(from: card)
        RealmHelper.addObject(newCard)
    }
    
    func generateCardTypes() -> [String] {
        guard cardTypes.isEmpty else {
            listener?(.success)
            return cardTypes
        }
        getCardTypes()
        
        if cardTypes.isEmpty {
            self.listener?(.error(message: "No Card Types Available"))
        } else {
            self.listener?(.success)
        }
        return cardTypes
    }

    func getCardTypes() {
        for type in CardType.allCases {
            cardTypes.append(type.rawValue)
        }
    }

    func getItems() -> Int {
        return CardType.allCases.count
    }
}

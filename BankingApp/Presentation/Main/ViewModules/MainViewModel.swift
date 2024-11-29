//
//  MainViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 19.11.24.
//

import Foundation

final class MainViewModel {
    enum ViewState {
        case error(message: String)
        case success
        case loading
        case loaded
        case noCards
    }
    
    var listener: ((ViewState) -> Void)?
    private var cards: [Card] = []
    
    func generateCards() -> [Card]? {
        guard cards.isEmpty else {
            listener?(.success)
            return cards
        }
        listener?(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getCards()
            if self.cards.isEmpty {
                self.listener?(.noCards)
            } else {
                self.listener?(.success)
            }
            self.listener?(.loaded)
        }
        return cards
    }
    
    fileprivate func getCards() {
        let user = UserDefaults.standard.string(forKey: "userID")?.userForIDstring()
        self.cards = Array(RealmHelper.fetchObjects(Card.self).filter({$0.owner == user}))
    }
    
    func getItems() -> Int {
        getCards()
        if self.cards.isEmpty {
            self.listener?(.error(message: "No Card Found"))
        } else {
            self.listener?(.success)
        }
        return cards.count
    }
}

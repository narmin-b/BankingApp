//
//  MainViewModel.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 19.11.24.
//

import Foundation

final class MainViewModel {
    enum ViewState {
        case loading
        case loaded
    }
    
    var listener: ((ViewState) -> Void)?{
        didSet {
            listener?(.loading)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.listener?(.loaded)
            }
        }
    }
    
//    func generateCards() -> Card {
//        let user = UserDefaults.standard.string(forKey: "userID")?.userForIDstring()
//        let card = realm.objects(Card.self).first(where: { $0.owner == user }) ?? Card()
//        return card
//    }
}

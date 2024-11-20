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
    
    var listener: ((ViewState) -> Void)?

    init() {
        self.listener?(.loading)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.listener?(.loaded)
        }
    }
}

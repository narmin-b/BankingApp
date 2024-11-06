//
//  UILabel+ Extension.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 06.11.24.
//

import Foundation
import UIKit

extension String {
    func isValidEmail() -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: self)
    }
    
    func isUsernameValid() -> Bool {
        let unameRegex = "\\w{4,10}"
        let unamePredicate = NSPredicate(format:"SELF MATCHES %@", unameRegex)
        
        return unamePredicate.evaluate(with: self)
    }
    
    func isPasswordValid() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z0-9]{4,}).+$"
        let passwordPredicate = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        
        return passwordPredicate.evaluate(with: self)
    }
}

extension Double {
    func convertToString() -> String {
        return String(self)
    }
}

extension Int {
    func convertToString() -> String {
        return String(self)
    }
}

extension UITextField {
    func errorBorderOn() {
        self.layer.borderColor = UIColor.errorBorderOn.cgColor
    }
    
    func errorBorderOff() {
        self.layer.borderColor = UIColor.errorBorderOff.cgColor
    }
}

extension UITableView {
    private func reuseIndentifier<T>(for type: T.Type) -> String {
        return String(describing: type)
    }

    public func register<T: UITableViewCell>(cell: T.Type) {
        register(T.self, forCellReuseIdentifier: reuseIndentifier(for: cell))
    }

    public func register<T: UITableViewHeaderFooterView>(headerFooterView: T.Type) {
        register(T.self, forHeaderFooterViewReuseIdentifier: reuseIndentifier(for: headerFooterView))
    }

    public func dequeueReusableCell<T: UITableViewCell>(for type: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: reuseIndentifier(for: type), for: indexPath) as? T else {
            fatalError("Failed to dequeue cell.")
        }

        return cell
    }

    public func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for type: T.Type) -> T {
        guard let view = dequeueReusableHeaderFooterView(withIdentifier: reuseIndentifier(for: type)) as? T else {
            fatalError("Failed to dequeue footer view.")
        }

        return view
    }
}

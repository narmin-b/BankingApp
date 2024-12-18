//
//  UILabel+ Extension.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 06.11.24.
//

import Foundation
import UIKit
import RealmSwift

extension String {
    func isFullNameValid() -> Bool {
        let fullNameRegex = "^(?=.*[a-zA-Z]{2})[a-zA-Z\\s]*$"
        let fullNamePredicate = NSPredicate(format: "SELF MATCHES %@", fullNameRegex)
        
        return fullNamePredicate.evaluate(with: self)
    }
    
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
    
    func userForIDstring() -> User? {
        guard let userID = try? ObjectId(string: self) else { return User() }
        let user = RealmHelper.fetchObject(User.self, primaryKey: userID)
        
        return user
    }
    
    func cardForCardNoString() -> Card? {
        guard let cardNo = Int(self) else { return nil }
        let card = RealmHelper.fetchObjects(Card.self).first(where: { $0.cardNo == cardNo })
        
        return card
    }
    
    func dropLast2() -> String {
        String(self.dropLast(2))
    }
    
    func strToDouble() -> Double? {
        Double(self)
    }
    
    func strToInt() -> Int? {
        Int(self)
    }
}

extension Double {
    func convertToString() -> String {
        return String(self)
    }
    
    func isBalanceValid() -> Bool {
        let num = Double(self)
        if num >= 0 {return true}
        return false
    }
}

extension Int {
    func convertToString() -> String {
        return String(self)
    }
    
    func isCardNoValid() -> Bool {
        let num = String(self).count
        if num == 12 {return true}
        return false
    }
    
    func isPinValid() -> Bool {
        let num = String(self).count
        if num == 4 {return true}
        return false
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

extension UIView {
    func addSubViews(_ views: UIView...) {
        views.forEach{addSubview($0)}
    }
}

extension UIStackView {
    func addArrangedSubViews(_ views: UIView...) {
        views.forEach{addArrangedSubview($0)}
    }
}

extension UIViewController {
    func showMessage(
        title: String = "",
        message: String = "",
        actionTitle: String = "OK"
    ) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertController.Style.alert
        )
        alert.addAction(UIAlertAction(title: actionTitle, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

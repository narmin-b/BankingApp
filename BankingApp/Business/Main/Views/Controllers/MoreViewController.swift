//
//  MoreViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import UIKit

class MoreViewController: UIViewController {
    private lazy var logOutButton: UIButton = {
        let button = ReusableButton(title: "Log Out", onAction: logOutButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    fileprivate func configureView() {
        view.addSubview(logOutButton)
        
        configureConstraint()
    }
    
    fileprivate func configureConstraint() {
        NSLayoutConstraint.activate([
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            logOutButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logOutButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            logOutButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc private func logOutButtonTapped() {
        UserDefaults.standard.set("", forKey: "userID")
        UserDefaults.standard.set(false, forKey: "isLoggedIn")
        showLogin()
    }
    
    fileprivate func showLogin() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.switchToLogin()
        }
    }
}

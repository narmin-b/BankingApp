//
//  MainViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit

class MainViewController: BaseViewController {
    private lazy var profileIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var profileInfo: UILabel = {
        let label = UILabel()
        label.text = "Hi, " + (UserDefaults.standard.string(forKey: "firstname") ?? "") + "!"
        
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileIcon, profileInfo])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 16
        stack.backgroundColor = .blue
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedIn()
        
        configureView()
        
    }
    
    override func configureView() {
        view.addSubview(profileStack)
        
        configureConstraint()
    }
    
    override func configureConstraint() {
        NSLayoutConstraint.activate([
            profileStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            profileStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            profileStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            profileIcon.leftAnchor.constraint(equalTo: profileStack.leftAnchor, constant: 0),
            profileIcon.centerYAnchor.constraint(equalTo: profileStack.centerYAnchor),
            profileInfo.centerYAnchor.constraint(equalTo: profileStack.centerYAnchor),

        ])
    }
    
    fileprivate func isLoggedIn() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            UserDefaults.standard.setValue(1, forKey: "loginType")
        }
    }
}


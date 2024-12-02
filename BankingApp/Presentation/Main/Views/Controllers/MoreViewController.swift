//
//  MoreViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 12.11.24.
//

import UIKit

enum infoList: String, CaseIterable {
    case username
    case email
}

class MoreViewController: UIViewController {
    private lazy var profileIcon: UIImageView = {
        let imageview = UIImageView()
        imageview.image = UIImage(named: "profile")
        imageview.contentMode = .scaleToFill
        imageview.layer.cornerRadius = 64
        imageview.layer.masksToBounds = true
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    private lazy var profileName: UILabel = {
        let user = UserDefaults.standard.string(forKey: "userID")?.userForIDstring()
        let profileName = (user?.firstName ?? "") + " " + (user?.lastName ?? "")
        
        let label = ReusableLabel(labelText: profileName, labelFont: UIFont(name: "Futura", size: 28))
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var infoTableView: UITableView = {
        let table = UITableView()
        table.delegate = self
        table.dataSource = self
        table.register(cell: InfoTableCell.self)
        table.isScrollEnabled = false
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private lazy var logOutButton: UIButton = {
        let button = ReusableButton(title: "Log Out", onAction: logOutButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        infoTableView.reloadData()
        print(infoList.allCases.count)
    }
    
    fileprivate func configureView() {
        view.addSubViews(profileIcon, profileName, infoTableView, logOutButton)
        
        configureConstraint()
    }
    
    fileprivate func configureConstraint() {
        NSLayoutConstraint.activate([
            profileIcon.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            profileIcon.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileIcon.heightAnchor.constraint(equalToConstant: 128),
            profileIcon.widthAnchor.constraint(equalToConstant: 128),
        ])
        
        NSLayoutConstraint.activate([
            profileName.topAnchor.constraint(equalTo: profileIcon.bottomAnchor, constant: 8),
            profileName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileName.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            profileName.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            infoTableView.topAnchor.constraint(equalTo: profileName.bottomAnchor, constant: 16),
            infoTableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            infoTableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            infoTableView.heightAnchor.constraint(equalToConstant: 128),
        ])
        
        NSLayoutConstraint.activate([
            logOutButton.topAnchor.constraint(equalTo: infoTableView.bottomAnchor, constant: 28),
            logOutButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            logOutButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
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

extension MoreViewController :UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        infoList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = UserDefaultsHelper.getString(key: "userID")?.userForIDstring()
        let cell = tableView.dequeueReusableCell(for: InfoTableCell.self, for: indexPath)
        
        let field = infoList.allCases[indexPath.row]
        let subtitle: String
        switch field {
        case .username:
            subtitle = user?.firstName ?? ""
        case .email:
            subtitle = user?.email ?? ""
        }
        
        cell.configureCell(title: field, subtitle: subtitle)
        return cell
    }
}

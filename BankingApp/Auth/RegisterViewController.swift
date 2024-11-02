//
//  RegisterViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {
    
    let realm = try! Realm()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var usernameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var emailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var passwordStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    private lazy var scrollStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameStack, emailStack, passwordStack])
        stack.axis = .vertical
        stack.spacing = 12
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Register", attributes: [.font: UIFont(name: "Futura", size: 18)]), for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", realm.configuration.fileURL!)
        
        view.backgroundColor = .systemBackground
        configureView()
    }
    
    fileprivate func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStack)
    }
    
    fileprivate func configureView() {
        view.addSubview(signUpLabel)
//        view.addSubview(usernameStack)
//        view.addSubview(emailStack)
//        view.addSubview(passwordStack)
        configureScrollView()
        view.addSubview(registerButton)
        
        NSLayoutConstraint.activate([
            view.safeAreaLayoutGuide.leftAnchor.constraint(equalTo: view.leftAnchor),
            view.safeAreaLayoutGuide.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])

        NSLayoutConstraint.activate([
            signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signUpLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -80),
            scrollStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            scrollStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 20),
            scrollStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: -20),
            scrollStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            usernameStack.topAnchor.constraint(equalTo: scrollStack.topAnchor, constant: 0),
            usernameStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 0),
            usernameStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: 0),
            usernameTextField.rightAnchor.constraint(equalTo: usernameStack.rightAnchor, constant: 0),
            usernameTextField.heightAnchor.constraint(equalToConstant: 44),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            emailStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 0),
            emailStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: 0),
            emailTextField.rightAnchor.constraint(equalTo: emailStack.rightAnchor, constant: 0),
            emailTextField.heightAnchor.constraint(equalToConstant: 44),
            passwordStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 0),
            passwordStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: 0),
            passwordTextField.rightAnchor.constraint(equalTo: passwordStack.rightAnchor, constant: 0),
            passwordTextField.heightAnchor.constraint(equalToConstant: 44),
        ])
        
//        NSLayoutConstraint.activate([
//            usernameStack.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
//            usernameStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            usernameStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            usernameTextField.rightAnchor.constraint(equalTo: usernameStack.rightAnchor, constant: 0),
//            usernameTextField.heightAnchor.constraint(equalToConstant: 44)
//        ])
//        
//        NSLayoutConstraint.activate([
//            emailStack.topAnchor.constraint(equalTo: usernameStack.bottomAnchor, constant: 12),
//            emailStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            emailStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            emailTextField.rightAnchor.constraint(equalTo: emailStack.rightAnchor, constant: 0),
//            emailTextField.heightAnchor.constraint(equalToConstant: 44)
//        ])
//        
//        NSLayoutConstraint.activate([
//            passwordStack.topAnchor.constraint(equalTo: emailStack.bottomAnchor, constant: 12),
//            passwordStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
//            passwordStack.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
//            passwordTextField.rightAnchor.constraint(equalTo: passwordStack.rightAnchor, constant: 0),
//            passwordTextField.heightAnchor.constraint(equalToConstant: 44)
//        ])
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 44)
        ])
    }
    
    @objc fileprivate func registerButtonTapped() {
        let user = User()
        user.username = usernameTextField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text
        try? realm.write {
            realm.add(user)
        }
        usernameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
        let vc = LoginViewController()
        navigationController?.pushViewController(LoginViewController(), animated: true)
    }
}

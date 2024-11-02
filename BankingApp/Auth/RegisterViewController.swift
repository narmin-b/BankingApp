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
        
        let leftIcon = UIImageView(image: UIImage(systemName: "person"))
        leftIcon.tintColor = .black
        leftIcon.contentMode = .center
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: leftIcon.frame.height))
        leftIcon.frame = CGRect(x: 10, y: 0, width: leftIcon.frame.width, height: leftIcon.frame.height)
        leftPaddingView.addSubview(leftIcon)
        
        textfield.leftView = leftPaddingView
        textfield.leftViewMode = .always
        
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var usernameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameLabel, usernameTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
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
        
        let leftIcon = UIImageView(image: UIImage(systemName: "envelope"))
        leftIcon.tintColor = .black
        leftIcon.contentMode = .center
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: leftIcon.frame.height))
        leftIcon.frame = CGRect(x: 10, y: 0, width: leftIcon.frame.width, height: leftIcon.frame.height)
        leftPaddingView.addSubview(leftIcon)
        
        textfield.leftView = leftPaddingView
        textfield.leftViewMode = .always
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var emailStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [emailLabel, emailTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
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
        
        let leftIcon = UIImageView(image: UIImage(systemName: "lock"))
        leftIcon.tintColor = .black
        leftIcon.contentMode = .center
        let leftPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: leftIcon.frame.height))
        leftIcon.frame = CGRect(x: 10, y: 0, width: leftIcon.frame.width, height: leftIcon.frame.height)
        leftPaddingView.addSubview(leftIcon)
        
        textfield.leftView = leftPaddingView
        textfield.leftViewMode = .always
        
        let rightIcon = UIImageView(image: UIImage(systemName: "eye.fill"))
        rightIcon.tintColor = .black
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: rightIcon.frame.height))
        rightIcon.frame = CGRect(x: -5, y: 0, width: rightIcon.frame.width, height: rightIcon.frame.height)
        rightPaddingView.addSubview(rightIcon)
        
        textfield.rightView = rightPaddingView
        textfield.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        rightIcon.isUserInteractionEnabled = true
        rightIcon.addGestureRecognizer(tapGestureRecognizer)
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var passwordStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [passwordLabel, passwordTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
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
        stack.spacing = 16
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
        configureScrollView()
        view.addSubview(registerButton)
        
        configureConstraints()
    }
    
    fileprivate func configureConstraints() {
        NSLayoutConstraint.activate([
            signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signUpLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400),
            
            scrollStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            scrollStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
            scrollStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
            scrollStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            scrollStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            usernameStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 20),
            usernameStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            emailStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 20),
            emailStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: -20),
            emailTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 20),
            passwordStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        NSLayoutConstraint.activate([
            registerButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            registerButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            registerButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            registerButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    @objc fileprivate func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        
        if passwordTextField.isSecureTextEntry {
            tappedImage?.image = UIImage(systemName: "eye.fill")
        } else {
            tappedImage?.image = UIImage(systemName: "eye.slash.fill")
        }
        passwordTextField.isSecureTextEntry.toggle()

    }
    
    @objc fileprivate func registerButtonTapped() {
        if isUsernameValid() && isEmailValid() && isPasswordValid() {
            saveUser()
            usernameTextField.text = ""
            emailTextField.text = ""
            passwordTextField.text = ""
            let vc = LoginViewController()
            navigationController?.pushViewController(LoginViewController(), animated: true)
        }
        else {
            print("Error")
        }
    }
    
    fileprivate func isUsernameValid() -> Bool {
        let uname = usernameTextField.text
        let regEx = "\\w{4,10}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: uname)
    }
    
    fileprivate func isEmailValid() -> Bool {
        let email = emailTextField.text
        let regEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: email)
    }
    
    fileprivate func isPasswordValid() -> Bool {
        let password = passwordTextField.text
        let regEx = "^(?=.*[A-Za-z0-9]{4,}).+$"
        let test = NSPredicate(format:"SELF MATCHES %@", regEx)
        return test.evaluate(with: password)
    }
    
    fileprivate func saveUser() {
        let user = User()
        user.username = usernameTextField.text
        user.email = emailTextField.text
        user.password = passwordTextField.text
        
        try? realm.write {
            realm.add(user)
        }
    }
}

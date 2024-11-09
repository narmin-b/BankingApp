//
//  LoginViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController {

    let realm = try! Realm()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Log Back In"
        label.textColor = .basicText
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = UILabel()
        label.text = "Username"
        label.textColor = .basicText
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)!])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        
        textfield.leftView = iconSetting("person")
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
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.textColor = .basicText
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)!])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12

        textfield.leftView = iconSetting("lock")
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
        let stack = UIStackView(arrangedSubviews: [usernameStack, passwordStack])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Log In", attributes: [.font: UIFont(name: "Futura", size: 18)!]), for: .normal)
        button.layer.cornerRadius = 12
        button.titleLabel?.textAlignment = .center
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerLabel: UILabel = {
        let label = UILabel()
        label.text = "Don't have an account yet?"
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Register", attributes: [.font: UIFont(name: "Futura", size: 12)!, .foregroundColor: UIColor.gray]), for: .normal)
        button.addTarget(self, action: #selector(registerButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var registerStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [registerLabel, registerButton])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaultsHelper.setInteger(key: UserDefaultsKey.loginType.rawValue, value: 0)
        print("Realm is located at:", realm.configuration.fileURL!)

        view.backgroundColor = .systemBackground
        configureView()
    }
    
    fileprivate func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStack)
    }
    
    fileprivate func configureView() {
        view.addSubview(loginLabel)
        configureScrollView()
        view.addSubview(loginButton)
        view.addSubview(registerStack)
        
        configureConstraints()
    }
    
    fileprivate func configureConstraints() {
        NSLayoutConstraint.activate([
            loginLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: loginLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -485),
            
            scrollStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            scrollStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
            scrollStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
            scrollStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            scrollStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            usernameStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 20),
            usernameStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: -20),
            usernameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            passwordStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 20),
            passwordStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: -20),
            passwordTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            registerStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            registerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
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
    
    @objc fileprivate func loginButtonTapped() {
        if isUserValid() {
            showMain()
        }
        else {print("error")}
    }
    
    fileprivate func showMain() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.switchToMain()
        }
    }
    
    
    fileprivate func isUserValid() -> Bool {
        let uname = usernameTextField.text
        let password = passwordTextField.text
        if let user = realm.objects(User.self).filter({$0.username == uname}).first {
            usernameTextField.errorBorderOff()
            if user.password == password {
                passwordTextField.errorBorderOff()
                return true
            }
            else {
                passwordTextField.errorBorderOn()
                return false
            }
        }
        else {
            usernameTextField.errorBorderOn()
            passwordTextField.errorBorderOn()
        }
        return false
    }
    
    fileprivate func iconSetting(_ iconName: String, x: Int = 10) -> UIView {
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = .black
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: icon.frame.height))
        icon.frame = CGRect(x: CGFloat(integerLiteral: x), y: 0, width: icon.frame.width, height: icon.frame.height)
        paddingView.addSubview(icon)
        return paddingView
    }
    
    @objc fileprivate func registerButtonTapped() {
        let controller = RegisterViewController()
        controller.delegate = self
        navigationController?.pushViewController(controller, animated: true)
    }
}

extension LoginViewController: RegisterViewControllerDelegate {
    func didRegister() {
        let user = realm.objects(User.self).last
        usernameTextField.text = user?.username
        passwordTextField.text = user?.password
    }
}

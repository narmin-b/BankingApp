//
//  RegisterViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit
import RealmSwift

protocol RegisterViewControllerDelegate: AnyObject {
    func didRegister()
}

class RegisterViewController: BaseViewController {
    
    let realm = try! Realm()
    weak var delegate: RegisterViewControllerDelegate?
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Register"
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 32)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstNameLabel: UILabel = {
        let label = UILabel()
        label.text = "First Name"
        label.textColor = .basicText
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var firstNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "First Name", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)!])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        
        textfield.leftView = iconUISetting("person")
        textfield.leftViewMode = .always
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var firstNameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [firstNameLabel, firstNameTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var lastNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Last Name"
        label.textColor = .basicText
        label.textAlignment = .left
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var lastNameTextField: UITextField = {
        let textfield = UITextField()
        textfield.attributedPlaceholder = NSAttributedString(string: "Last Name", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)!])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        
        textfield.leftView = iconUISetting("person")
        textfield.leftViewMode = .always
        
        textfield.translatesAutoresizingMaskIntoConstraints = false
        return textfield
    }()
    
    private lazy var lastNameStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [lastNameLabel, lastNameTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
        textfield.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)!])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        
        textfield.leftView = iconUISetting("person.text.rectangle")
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
        textfield.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)!])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        textfield.keyboardType = .emailAddress
        
        textfield.leftView = iconUISetting("envelope")
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
        textfield.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [.foregroundColor: UIColor.lightGray, .font: UIFont(name: "Futura", size: 12)!])
        textfield.borderStyle = .roundedRect
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.layer.borderWidth = 2
        textfield.layer.cornerRadius = 12
        
        textfield.leftView = iconUISetting("lock", x: 13)
        textfield.leftViewMode = .always
        
        let rightIcon = UIImageView(image: UIImage(systemName: "eye.fill"))
        rightIcon.tintColor = .black
        let rightPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: rightIcon.frame.height))
        rightIcon.frame = CGRect(x: -5, y: 0, width: rightIcon.frame.width, height: rightIcon.frame.height)
        rightPaddingView.addSubview(rightIcon)
        
        textfield.rightView = rightPaddingView
        textfield.rightViewMode = .always
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
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
        let stack = UIStackView(arrangedSubviews: [firstNameStack, lastNameStack, usernameStack, emailStack, passwordStack])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var registerButton: UIButton = {
        let button = ReusableButton(title: "Register", onAction: registerButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.text = "Already have an account?"
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loginButton: UIButton = {
        let button = UIButton()
        button.setAttributedTitle(NSAttributedString(string: "Login", attributes: [.font: UIFont(name: "Futura", size: 12)!, .foregroundColor: UIColor.gray]), for: .normal)
        button.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loginStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loginLabel, loginButton])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .center
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let viewModel: RegisterViewModel
    
    init(viewModel: RegisterViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.setHidesBackButton(true, animated: true)

        configureView()
        configureViewModel()
    }
    
    fileprivate func configureViewModel() {
        viewModel.delegate = self
    }
    
    fileprivate func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStack)
    }
    
    override func configureView() {
        super.configureView()

        view.addSubview(signUpLabel)
        configureScrollView()
        view.addSubview(registerButton)
        view.addSubview(loginStack)
        
        configureConstraint()
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            signUpLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            signUpLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
        
        NSLayoutConstraint.activate([
            scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0),
            scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0),
            scrollView.topAnchor.constraint(equalTo: signUpLabel.bottomAnchor, constant: 20),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -236),
            
            scrollStack.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0),
            scrollStack.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0),
            scrollStack.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0),
            scrollStack.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0),
            scrollStack.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            firstNameStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 20),
            firstNameStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: -20),
            firstNameTextField.heightAnchor.constraint(equalToConstant: 48),
            
            lastNameStack.leftAnchor.constraint(equalTo: scrollStack.leftAnchor, constant: 20),
            lastNameStack.rightAnchor.constraint(equalTo: scrollStack.rightAnchor, constant: -20),
            lastNameTextField.heightAnchor.constraint(equalToConstant: 48),
            
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
        
        NSLayoutConstraint.activate([
            loginStack.topAnchor.constraint(equalTo: registerButton.bottomAnchor, constant: 24),
            loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    fileprivate func iconUISetting(_ iconName: String, x: Int = 10) -> UIView {
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = .black
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: icon.frame.height))
        icon.frame = CGRect(x: CGFloat(integerLiteral: x), y: 0, width: icon.frame.width, height: icon.frame.height)
        paddingView.addSubview(icon)
        return paddingView
    }
    
    override func configureTargets() {
        super.configureTargets()
    }
    
    @objc fileprivate func imageTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        
        if passwordTextField.isSecureTextEntry {
            tappedImage?.image = UIImage(systemName: "eye.fill")
        } else {
            tappedImage?.image = UIImage(systemName: "eye.slash.fill")
        }
        passwordTextField.isSecureTextEntry.toggle()
    }
    
    fileprivate func fieldReset() {
        firstNameTextField.text = ""
        lastNameTextField.text = ""
        usernameTextField.text = ""
        emailTextField.text = ""
        passwordTextField.text = ""
    }
    
    @objc fileprivate func loginButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc fileprivate func registerButtonTapped() {
        viewModel.setInput(firstName: firstNameTextField.text!, lastName: lastNameTextField.text!, username: usernameTextField.text!, password: passwordTextField.text!, email: emailTextField.text!)
        if viewModel.isAllInputValid() {
            viewModel.saveUser()
            delegate?.didRegister()
            fieldReset()
            navigationController?.popViewController(animated: true)
        }
    }
}

extension RegisterViewController: RegisterViewModelDelegate {
    func fieldError(_ type: ValidationType) {
        switch type {
        case .firstName:
            firstNameTextField.errorBorderOn()
        case .lastName:
            lastNameTextField.errorBorderOn()
        case .username:
            usernameTextField.errorBorderOn()
        case .email:
            emailTextField.errorBorderOn()
        case .password:
            passwordTextField.errorBorderOn()
        }
    }
    
    func fieldValid(_ type: ValidationType) {
        switch type {
        case .firstName:
            firstNameTextField.errorBorderOff()
        case .lastName:
            lastNameTextField.errorBorderOff()
        case .username:
            usernameTextField.errorBorderOff()
        case .email:
            emailTextField.errorBorderOff()
        case .password:
            passwordTextField.errorBorderOff()
        }
    }
}

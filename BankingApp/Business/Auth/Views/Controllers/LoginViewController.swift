//
//  LoginViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit
import RealmSwift

class LoginViewController: BaseViewController {
    let realm = try! Realm()
    private var isKeepLoggedIn: Bool = false
    
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
        
        textfield.leftView = iconUISetting("person")
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

        textfield.leftView = iconUISetting("lock")
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
    
    private lazy var loggedButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square"), for: .normal)
        button.imageView?.tintColor = .basicText
        button.setTitle("", for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(keepLoggedInTapped), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var loggedLabel: UILabel = {
        let label = UILabel()
        label.text = "Keep me logged in"
        label.font = UIFont(name: "Futura", size: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var loggedStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [loggedButton, loggedLabel])
        stack.axis = .horizontal
        stack.spacing = 2
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var scrollStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [usernameStack, passwordStack, loggedStack])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .leading
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var loginButton: UIButton = {
        let button = ReusableButton(title: "Log In", onAction: loginButtonTapped)
        
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
    
    private let viewModel: LoginViewModel
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("Realm is located at:", realm.configuration.fileURL!)
        UserDefaults.standard.setValue(0, forKey: "loginType")

        configureViewModel()
        configureView()
    }
    
    fileprivate func configureScrollView() {
        view.addSubview(scrollView)
        scrollView.addSubview(scrollStack)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubview(loginLabel)
        configureScrollView()
        view.addSubview(loginButton)
        view.addSubview(registerStack)
        
        configureConstraint()
    }
    
    override func configureConstraint() {
        super.configureConstraint()
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
            
            loggedStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loggedStack.heightAnchor.constraint(equalToConstant: 16)
        ])
        
        NSLayoutConstraint.activate([
            loginButton.topAnchor.constraint(equalTo: loggedButton.bottomAnchor, constant: 24),
            loginButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            loginButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            loginButton.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            registerStack.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: 24),
            registerStack.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    override func configureTargets() {
        super.configureTargets()
    }
    
    fileprivate func configureViewModel() {
        viewModel.delegate = self
    }
    
    fileprivate func iconUISetting(_ iconName: String, x: Int = 10) -> UIView {
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = .black
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: icon.frame.height))
        icon.frame = CGRect(x: CGFloat(integerLiteral: x), y: 0, width: icon.frame.width, height: icon.frame.height)
        paddingView.addSubview(icon)
        return paddingView
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
    
    @objc fileprivate func keepLoggedInTapped() {
        isKeepLoggedIn.toggle()

        let imageName = isKeepLoggedIn ? "checkmark.square.fill" : "square"
        loggedButton.setImage(UIImage(systemName: imageName), for: .normal)
        UserDefaults.standard.setValue(isKeepLoggedIn, forKey: "isLoggedIn")
    }
    
    @objc fileprivate func loginButtonTapped() {
        viewModel.setInput(username: usernameTextField.text!, password: passwordTextField.text!)
        if viewModel.isUserValid() {
            usernameTextField.errorBorderOff()
            passwordTextField.errorBorderOff()
            viewModel.saveLoggedUser()
            showMain()
        }
        else {print("error")}
    }
    
    fileprivate func showMain() {
        if let scene = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate {
            scene.switchToMain()
        }
    }
    
    @objc fileprivate func registerButtonTapped() {
        let controller = RegisterViewController(viewModel: RegisterViewModel())
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

extension LoginViewController: LoginViewModelDelegate {
    
    func userError() {
        usernameTextField.errorBorderOn()
        passwordTextField.errorBorderOn()
    }
    
    func passwordError() {
        passwordTextField.errorBorderOn()
    }
    
}

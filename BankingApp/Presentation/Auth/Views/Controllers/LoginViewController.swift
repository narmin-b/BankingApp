//
//  LoginViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit

class LoginViewController: BaseViewController {
    private var isKeepLoggedIn: Bool = false
    
    private lazy var loginLabel: UILabel = {
        let label = ReusableLabel(labelText: "Log Back In", labelFont: UIFont(name: "Futura", size: 32))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameLabel: UILabel = {
        let label = ReusableLabel(labelText: "Username")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var usernameTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Username", iconName: "person", iconSetting: nil)
        
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
        let label = ReusableLabel(labelText: "Password")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate func iconUISetting(_ iconName: String, x: Int = 10) -> UIView {
        let icon = UIImageView(image: UIImage(systemName: iconName))
        icon.tintColor = .black
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: icon.frame.height))
        icon.frame = CGRect(x: CGFloat(integerLiteral: x), y: 0, width: icon.frame.width, height: icon.frame.height)
        paddingView.addSubview(icon)
        return paddingView
    }
    
    private lazy var passwordTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Password", iconName: "lock", iconSetting: nil)
        
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
        let label = ReusableLabel(labelText: "Keep me logged in")
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
        let label = ReusableLabel(labelText: "Don't have an account yet?")
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
        UserDefaults.standard.setValue(0, forKey: "loginType")
        
        configureViewModel()
        configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        passwordTextField.errorBorderOff()
        usernameTextField.errorBorderOff()
    }
    
    fileprivate func configureScrollView() {
        scrollView.addSubViews(scrollStack)
    }
    
    override func configureView() {
        super.configureView()
        view.addSubViews(loginLabel, scrollView, loginButton, registerStack)
        configureScrollView()
        
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
            scrollView.centerXAnchor
//            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -485),
            
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
        viewModel.listener = { [weak self] state in
            guard let self else {return}
            switch state {
            case .error(let message):
                showMessage(title: "Error", message: message)
            case .success:
                print(#function)
            case .userError:
                usernameTextField.errorBorderOn()
                passwordTextField.errorBorderOn()
            case .passwordError:
                passwordTextField.errorBorderOn()
            }
        }
    }
    
    @objc fileprivate func imageTapped(_ tapGestureRecognizer: UITapGestureRecognizer) {
        let tappedImage = tapGestureRecognizer.view as? UIImageView
        
        tappedImage?.image = UIImage(systemName: passwordTextField.isSecureTextEntry ? "eye.fill" : "eye.slash.fill")
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
            showMain()
        }
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
        let user = RealmHelper.fetchObjects(User.self).last
        usernameTextField.text = user?.username
        passwordTextField.text = user?.password
    }
}

//extension LoginViewController: LoginViewModelDelegate {
//    
//    func userError() {
//        
//    }
//    
//    func passwordError() {
//    }
//    
//}

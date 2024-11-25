//
//  TransferViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 24.11.24.
//

import UIKit

class TransferViewController: BaseViewController {
    private var activeTextField: UITextField?
    
    private lazy var titleLabel: UILabel = {
        let label = ReusableLabel(labelText: "Transfer Money", labelFont: UIFont(name: "Futura", size: 28))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var senderLabel: UILabel = {
        let label = ReusableLabel(labelText: "Sender Card")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var senderTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Sender Card")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.inputAccessoryView = toolBar
        textfield.inputView = pickerView
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var senderStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [senderLabel, senderTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var receiverLabel: UILabel = {
        let label = ReusableLabel(labelText: "Receiver Card")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var receiverTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Receiver Card")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.inputAccessoryView = toolBar
        textfield.inputView = pickerView
        textfield.delegate = self
        return textfield
    }()
    
    private lazy var receiverStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [receiverLabel, receiverTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = ReusableLabel(labelText: "Transfer Amount")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var amountTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Amount")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.inputAccessoryView = toolBar
        textfield.delegate = self
        textfield.keyboardType = .decimalPad
        return textfield
    }()
    
    private lazy var amountStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [amountLabel, amountTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var toolBar: UIToolbar = {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        toolbar.items = [
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissPicker))
        ]
        return toolbar
    }()
    
    private lazy var pickerView: UIPickerView = {
        let view = UIPickerView()
        view.delegate = self
        view.dataSource = self
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configurePickerView() {
        senderTextField.inputView = pickerView
        receiverTextField.inputView = pickerView
    }
    
    @objc fileprivate func dismissPicker() {
        activeTextField?.resignFirstResponder()
    }
    
    override func configureView() {
        super.configureView()
        view.addSubViews(titleLabel, senderStackView, receiverStackView, amountStackView)
        configureConstraint()
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            senderStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            senderStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            senderStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            senderStackView.heightAnchor.constraint(equalToConstant: 78),
            
            senderTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        NSLayoutConstraint.activate([
            receiverStackView.topAnchor.constraint(equalTo: senderStackView.bottomAnchor, constant: 16),
            receiverStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            receiverStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            receiverStackView.heightAnchor.constraint(equalToConstant: 78),
            
            receiverTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
        
        NSLayoutConstraint.activate([
            amountStackView.topAnchor.constraint(equalTo: receiverStackView.bottomAnchor, constant: 16),
            amountStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            amountStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            amountStackView.heightAnchor.constraint(equalToConstant: 78),
            
            amountTextField.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
}

extension TransferViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return textField == amountTextField
    }
}

extension TransferViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.getItems()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let card = viewModel.generateCards()?[row]
        return card?.cardInfo()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let selectedCard = viewModel.generateCards()?[row] {
            activeTextField?.text = selectedCard.cardInfo()
        }
    }
}

//
//  AddCardViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 28.11.24.
//

import UIKit

protocol AddCardViewControllerDelegate: AnyObject {
    func reloadDataAddition()
}

class AddCardViewController: BaseViewController {
    var delegate: AddCardViewControllerDelegate?
    
    private lazy var titleLabel: UILabel = {
        let label = ReusableLabel(labelText: "Add card", labelFont: UIFont(name: "Futura", size: 28))
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardTypeLabel: UILabel = {
        let label = ReusableLabel(labelText: "Card Type")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardTypeTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Card Type")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.inputAccessoryView = toolBar
        textfield.inputView = pickerView
        return textfield
    }()
    
    private lazy var cardTypeStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cardTypeLabel, cardTypeTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var cardNoLabel: UILabel = {
        let label = ReusableLabel(labelText: "Card No")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardNoTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Card No")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .decimalPad
        return textfield
    }()
    
    private lazy var cardNoStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cardNoLabel, cardNoTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var pinLabel: UILabel = {
        let label = ReusableLabel(labelText: "PIN")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var pinTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "PIN")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .decimalPad
        return textfield
    }()
    
    private lazy var pinStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [pinLabel, pinTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var balanceLabel: UILabel = {
        let label = ReusableLabel(labelText: "Balance")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var balanceTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Balance")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .decimalPad
        return textfield
    }()
    
    private lazy var balanceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [balanceLabel, balanceTextField])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var inputStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [cardTypeStackView, cardNoStackView, pinStackView, balanceStackView])
        stack.axis = .vertical
        stack.spacing = 16
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var addCardButton: UIButton = {
        let button = ReusableButton(title: "Add Card", onAction: addCardButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
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

    private let viewModel: AddCardViewModel
    
    init(viewModel: AddCardViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
     required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureViewModel() {
        viewModel.listener = { [weak self] state in
            guard let self else {return}
            switch state {
            case .error(message: let message):
                showMessage(title: message)
            case .fieldError(let type):
                switch type {
                case .cardType:
                    cardTypeTextField.errorBorderOn()
                    showMessage(title: "Error", message: "Card Type Is Required")
                case .cardNo:
                    cardNoTextField.errorBorderOn()
                    showMessage(title: "Error", message: "Card Number Is Wrong")
                case .pin:
                    pinTextField.errorBorderOn()
                    showMessage(title: "Error", message: "PIN Is Wrong")
                case .balance:
                    balanceTextField.errorBorderOn()
                    showMessage(title: "Error", message: "Balance Must Be Over 0")
                }
            case .fieldValid(let type):
                switch type {
                case .cardType:
                    cardTypeTextField.errorBorderOff()
                case .cardNo:
                    cardNoTextField.errorBorderOff()
                case .pin:
                    pinTextField.errorBorderOff()
                case .balance:
                    balanceTextField.errorBorderOff()
                }
            case .success:
                print("Card valid")
            }
        }
    }
    
    fileprivate func configurePickerView() {
        cardTypeTextField.inputView = pickerView
    }
    
    override func configureView() {
        super.configureView()
        view.addSubViews(titleLabel, inputStackView, addCardButton)
        configureConstraint()
        configureViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cardTypeTextField.errorBorderOff()
        cardNoTextField.errorBorderOff()
        pinTextField.errorBorderOff()
        balanceTextField.errorBorderOff()
        fieldReset()
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        NSLayoutConstraint.activate([
            inputStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 32),
            inputStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            inputStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            inputStackView.heightAnchor.constraint(equalToConstant: 320),
            
            cardTypeTextField.heightAnchor.constraint(equalToConstant: 48),
            cardNoTextField.heightAnchor.constraint(equalToConstant: 48),
            pinTextField.heightAnchor.constraint(equalToConstant: 48),
            balanceTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
        
        NSLayoutConstraint.activate([
            addCardButton.topAnchor.constraint(equalTo: inputStackView.bottomAnchor, constant: 32),
            addCardButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            addCardButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            addCardButton.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
  
    @objc fileprivate func dismissPicker() {
        cardTypeTextField.resignFirstResponder()
    }
    
    @objc fileprivate func addCardButtonTapped() {
        viewModel.setInput(cardType: cardTypeTextField.text ?? "", cardNo: cardNoTextField.text ?? "", pin: pinTextField.text ?? "", balance: balanceTextField.text ?? "")
        if viewModel.isAllInputValid() {
            viewModel.addCard()
            delegate?.reloadDataAddition()
            fieldReset()
            dismiss(animated: true)
        }
    }
    
    fileprivate func fieldReset() {
        cardTypeTextField.text = ""
        cardNoTextField.text = ""
        pinTextField.text = ""
        balanceTextField.text = ""
    }
}

extension AddCardViewController : UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        viewModel.getItems()
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let type = viewModel.generateCardTypes()[row]
        return type
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedType = viewModel.generateCardTypes()[row]
                cardTypeTextField.text = selectedType
    }
}

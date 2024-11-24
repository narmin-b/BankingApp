//
//  TransferViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 24.11.24.
//

import UIKit

class TransferViewController: BaseViewController {
    private lazy var senderTextField: UITextField = {
        let textfield = ReusableTextField(placeholder: "Sender")
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.delegate = self
        return textfield
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
    }
    
    override func configureView() {
        super.configureView()
        view.addSubViews(senderTextField)
        configureConstraint()
    }
    
    override func configureConstraint() {
        super.configureConstraint()
        NSLayoutConstraint.activate([
            senderTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            senderTextField.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            senderTextField.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            senderTextField.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
}

extension TransferViewController : UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        configurePickerView()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return false
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
        let cards = viewModel.generateCards()?[row]
        return "****\(String(cards?.cardNo ?? 0).suffix(4)) - \(cards?.balance ?? 0) ₼"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if let selectedCard = viewModel.generateCards()?[row] {
            senderTextField.text = "****\(String(selectedCard.cardNo).suffix(4)) - \(selectedCard.balance ?? 0) ₼"
        }
    }
}



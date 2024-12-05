//
//  MainViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit

class MainViewController: BaseViewController {
    private lazy var profileIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.crop.circle")
        imageView.tintColor = .black
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var profileInfo: UILabel = {
        let label = UILabel()
        let user = UserDefaults.standard.string(forKey: "userID")?.userForIDstring()
        
        label.text = "Hi, " + (user?.firstName ?? "") + "!"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var profileStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [profileIcon, profileInfo])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillProportionally
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private lazy var cardCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = CGSize(width: 64, height: 24)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionCell.self, forCellWithReuseIdentifier: "CardCollectionCell")

        return collectionView
    }()
    
    private lazy var transferButton: UIButton = {
        let button = ReusableButton(title: "Transfer Money", onAction: transferButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var addCardButton: UIButton = {
        let button = ReusableButton(title: "Add Card", onAction: addCardButtonTapped)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private lazy var buttonStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [addCardButton, transferButton])
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.distribution = .fillEqually
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedIn()
        let user = UserDefaults.standard.string(forKey: "userID")?.userForIDstring()
        print(Array(RealmHelper.fetchObjects(Card.self).filter({$0.owner == user })))
        
        configureViewModel()
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
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.navigationController?.navigationBar.isHidden = true
    }
    
    fileprivate func configureCardView() {
        cardView.addSubViews(cardCollection)
    }
    
    override func configureView() {
        view.addSubViews(profileStack, cardView, buttonStackView, loadingView)
        configureCardView()
        configureConstraint()
    }
    
    fileprivate func configureViewModel() {
        viewModel.listener = { [weak self] state in
            guard let self else {return}
            switch state {
            case .loading:
                self.loadingView.startAnimating()
            case .loaded:
                self.loadingView.stopAnimating()
            case .error(let message):
                showMessage(title: message)
            case .success:
                print("card found")
            case .noCards:
                showMessage(title: "No card Found")
            }
        }
    }
    
    override func configureConstraint() {
        NSLayoutConstraint.activate([
            profileStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 4),
            profileStack.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            profileStack.heightAnchor.constraint(equalToConstant: 36),
            profileIcon.widthAnchor.constraint(equalToConstant: 36),
            profileIcon.leftAnchor.constraint(equalTo: profileStack.leftAnchor, constant: 0),
            profileIcon.centerYAnchor.constraint(equalTo: profileStack.centerYAnchor),
            profileInfo.centerYAnchor.constraint(equalTo: profileStack.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: profileStack.bottomAnchor, constant: 20),
            cardView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            cardView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            cardView.heightAnchor.constraint(equalToConstant: 280),
            
            cardCollection.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 20),
            cardCollection.leftAnchor.constraint(equalTo: cardView.leftAnchor, constant: 12),
            cardCollection.rightAnchor.constraint(equalTo: cardView.rightAnchor, constant: -12),
            cardCollection.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20),
        ])
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0),
            loadingView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 0),
            loadingView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: 0),
            loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0)
        ])
        NSLayoutConstraint.activate([
            buttonStackView.topAnchor.constraint(equalTo: cardView.bottomAnchor, constant: 28),
            buttonStackView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 20),
            buttonStackView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20),
            
            addCardButton.heightAnchor.constraint(equalToConstant: 48),
            transferButton.heightAnchor.constraint(equalToConstant: 48),
        ])
    }
    
    fileprivate func isLoggedIn() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            UserDefaults.standard.setValue(1, forKey: "loginType")
        }
    }
    
    @objc private func transferButtonTapped() {
        let controller = TransferViewController(viewModel: viewModel)
        controller.delegate = self
        controller.modalPresentationStyle = .formSheet
        present(controller, animated: true)
    }
    
    @objc private func addCardButtonTapped() {
        let controller = AddCardViewController(viewModel: AddCardViewModel())
        controller.delegate = self
        controller.modalPresentationStyle = .formSheet
        present(controller, animated: true)
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.getItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionCell", for: indexPath) as! CardCollectionCell
        let items = viewModel.generateCards()
        cell.configureCell(card: items?[indexPath.row])
        return cell
    }
}

extension MainViewController : TransferViewControllerDelegate, AddCardViewControllerDelegate {
    func reloadDataAddition() {
        cardCollection.reloadData()
    }
    
    func reloadDataTransfer() {
        cardCollection.reloadData()
    }
}

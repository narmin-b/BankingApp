//
//  MainViewController.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 02.11.24.
//

import UIKit

class MainViewController: BaseViewController {
    let color = [UIColor.red, UIColor.blue]
    
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
        layout.itemSize = CGSize(width: 64, height: 24)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 16
        layout.minimumLineSpacing = 20
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CardCollectionCell.self, forCellWithReuseIdentifier: "CardCollectionCell")

        return collectionView
    }()
    
    private lazy var loadingView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.tintColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedIn()
        
//        configureViewModel()
        configureView()
    }
    
    private let viewModel: MainViewModel
    
    init(viewModel: MainViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @MainActor required init?(coder: NSCoder) {
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
        view.addSubViews(profileStack, cardView, loadingView)
        configureCardView()
        configureConstraint()
    }
    
//    fileprivate func configureViewModel() {
//        viewModel.listener = { [weak self] state in
//            guard let self else {return}
//            switch state {
//            case .loading:
//                self.loadingView.startAnimating()
//            case .loaded:
//                self.loadingView.stopAnimating()
//            }
//        }
//    }
    
    override func configureConstraint() {
        NSLayoutConstraint.activate([
            loadingView.topAnchor.constraint(equalTo: view.topAnchor),
            loadingView.leftAnchor.constraint(equalTo: view.leftAnchor),
            loadingView.rightAnchor.constraint(equalTo: view.rightAnchor),
            loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
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
            cardCollection.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        ])
    }
    
    fileprivate func isLoggedIn() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            UserDefaults.standard.setValue(1, forKey: "loginType")
        }
    }
        
    func generateCards() -> Card? {
        let user = UserDefaults.standard.string(forKey: "userID")?.userForIDstring()
//        let card = RealmHelper.fetchObjects(Card.self).first(where: { $0.owner == user })
        return RealmHelper.fetchObjects(Card.self).first(where: { $0.owner == user })
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionCell", for: indexPath) as! CardCollectionCell
        cell.configureCell(color: color[indexPath.row], card: generateCards() ?? Card())
        return cell
    }
}

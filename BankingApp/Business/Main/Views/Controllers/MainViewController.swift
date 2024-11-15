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
        label.text = "Hi, " + (UserDefaults.standard.string(forKey: "firstname") ?? "") + "!"
        
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

    override func viewDidLoad() {
        super.viewDidLoad()
        isLoggedIn()
        
        configureView()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func configureView() {
        view.addSubview(profileStack)
        cardView.addSubview(cardCollection)
        view.addSubview(cardView)
        
        configureConstraint()
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
            cardCollection.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -20)
        ])
        
    }
    
    fileprivate func isLoggedIn() {
        if UserDefaults.standard.bool(forKey: "isLoggedIn") == true {
            UserDefaults.standard.setValue(1, forKey: "loginType")
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCollectionCell", for: indexPath) as! CardCollectionCell
        cell.configureCell(color: color[indexPath.row])
        return cell
    }
    
}

//
//  CardCollectionCell.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 13.11.24.
//

import UIKit

final class CardCollectionCell: UICollectionViewCell {
    private lazy var cardImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = .cardBG
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cardTypeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cardNoLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "**** 0000"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var cardBalanceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        label.textColor = .label
        label.textAlignment = .center
        label.text = "0 ₼"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
       
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell(card: Card?) {
        cardTypeImageView.image = UIImage(named: card?.cardType.lowercased() ?? "")
        cardNoLabel.text = "**** " + String(card?.cardNo ?? 0).suffix(4)
        cardBalanceLabel.text = String(card?.balance ?? 0) + " ₼"
    }
    
    fileprivate func configureView() {
        cardImageView.addSubViews(cardTypeImageView, cardNoLabel, cardBalanceLabel)
        addSubViews(cardImageView)
        
        configureConstraints()
    }
    
    fileprivate func configureConstraints() {
        cardImageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cardImageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        cardImageView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        cardImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cardImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cardImageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cardImageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        cardImageView.widthAnchor.constraint(equalToConstant: 340).isActive = true
        
        cardTypeImageView.bottomAnchor.constraint(equalTo: cardImageView.bottomAnchor, constant: -4).isActive = true
        cardTypeImageView.rightAnchor.constraint(equalTo: cardImageView.rightAnchor, constant: -8).isActive = true
        cardTypeImageView.heightAnchor.constraint(equalToConstant: 56).isActive = true
        cardTypeImageView.widthAnchor.constraint(equalToConstant: 56).isActive = true
//
        
        cardNoLabel.topAnchor.constraint(equalTo: cardImageView.topAnchor, constant: 12).isActive = true
        cardNoLabel.leftAnchor.constraint(equalTo: cardImageView.leftAnchor, constant: 12).isActive = true
        
        cardBalanceLabel.topAnchor.constraint(equalTo: cardNoLabel.bottomAnchor, constant: 8).isActive = true
        cardBalanceLabel.leftAnchor.constraint(equalTo: cardImageView.leftAnchor, constant: 12).isActive = true
    }
}

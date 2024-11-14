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
//        imageView.backgroundColor = .red
        imageView.layer.cornerRadius = 12
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var cardTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .label
        label.text = "Card"
        label.textAlignment = .center
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
    
    func configureCell(color: UIColor) {
        cardImageView.backgroundColor = color
    }
    
    fileprivate func configureView() {
        cardImageView.addSubview(cardTitleLabel)
        addSubview(cardImageView)
        
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
        
        cardTitleLabel.centerXAnchor.constraint(equalTo: cardImageView.centerXAnchor).isActive = true
        cardTitleLabel.centerYAnchor.constraint(equalTo: cardImageView.centerYAnchor).isActive = true
    }
}

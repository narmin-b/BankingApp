//
//  InfoTableCell.swift
//  BankingApp
//
//  Created by Narmin Baghirova on 30.11.24.
//

import UIKit

final class InfoTableCell: UITableViewCell {
    private lazy var titleLabel: UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura", size: 16)
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Test"
        label.textAlignment = .left
        label.numberOfLines = 1
        label.font = UIFont(name: "Futura", size: 16)
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
       let stack = UIStackView(arrangedSubviews: [titleLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = 4
        stack.alignment = .fill
        stack.distribution = .fill
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func configureUI() {
        addSubview(stackView)
        
        stackView.topAnchor.constraint(equalTo: topAnchor,constant: 12).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12).isActive = true
    }
    
    func configureCell(title: infoList, subtitle: String) {
        titleLabel.text = title.rawValue.capitalized
        subtitleLabel.text = subtitle
    }
}


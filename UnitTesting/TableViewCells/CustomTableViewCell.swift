//
//  CustomTableViewCell.swift
//  UnitTesting
//
//  Created by Jayesh Kawli on 8/24/19.
//  Copyright © 2019 Jayesh Kawli. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    private enum Constants {
        static let horizontalPadding: CGFloat = 16
        static let verticalPadding: CGFloat = 8
    }

    let idLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    }()

    let addressLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureSubviews()
        configureLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configureSubviews() {
        addSubview(idLabel)
        addSubview(nameLabel)
        addSubview(addressLabel)
    }

    func configureLayout() {
        idLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        addressLabel.translatesAutoresizingMaskIntoConstraints = false

        // MARK: Horizontal Constraints
        NSLayoutConstraint.activate([
            idLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
            idLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
            addressLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Constants.horizontalPadding),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Constants.horizontalPadding),
            ])

        // MARK: Vertical Constraints
        NSLayoutConstraint.activate([
            idLabel.topAnchor.constraint(equalTo: topAnchor, constant: Constants.verticalPadding),
            nameLabel.topAnchor.constraint(equalTo: idLabel.bottomAnchor, constant: Constants.verticalPadding),
            addressLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: Constants.verticalPadding),
            addressLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Constants.verticalPadding)
            ])
    }

    func apply(viewModel: ViewModel) {
        idLabel.text = viewModel.id
        nameLabel.text = viewModel.username
        addressLabel.text = viewModel.address
    }
}


//
//  IngredientsPrepTableViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPrepTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setup()
    }
    
    var ingredient: Ingredients? {
        didSet {
            self.label.text = self.ingredient?.name
            self.amount.text = "\(String(describing: self.ingredient?.amount))"
            self.measure.text = self.ingredient?.measurementType
        }
    }
    
    let label = UILabel()
    let checkMarkView = UILabel()
    let amount = UILabel()
    let measure = UILabel()
    let ingredientImg = UIImageView()
    
    private func setup() {
        self.backgroundColor = .yellow
        self.addAmount()
        self.addMeasure()
        self.addLabel()
        self.addCheckMarkView()
    }
    
    private func addAmount() {
        self.amount.font = UIFont.fontCoolvetica?.withSize(10)
        self.addSubview(self.amount)
        self.amount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.amount.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.amount.heightAnchor.constraint(equalToConstant: 15),
            self.amount.widthAnchor.constraint(equalToConstant: 35),
            self.amount.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
        ])
    }
    
    private func addMeasure() {
        self.measure.font = UIFont.fontCoolvetica?.withSize(10)
        self.addSubview(self.measure)
        self.measure.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.measure.leadingAnchor.constraint(equalTo: self.amount.trailingAnchor, constant: 5),
            self.measure.heightAnchor.constraint(equalToConstant: 15),
            self.measure.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.measure.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
            ])
    }
    
    private func addLabel() {
        self.label.font = UIFont.fontCoolvetica?.withSize(20)
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.label.bottomAnchor.constraint(equalTo: self.amount.topAnchor, constant: -5)
        ])
    }
    
    private func addCheckMarkView() {
        self.checkMarkView.font = UIFont.fontCoolvetica?.withSize(15)
        self.isHidden = true
        self.checkMarkView.backgroundColor = UIColor.black.withAlphaComponent(80)
        self.checkMarkView.textColor = .white
        self.addSubview(self.checkMarkView)
        self.checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checkMarkView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            self.checkMarkView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.checkMarkView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            self.checkMarkView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
            ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.checkMarkView.isHidden = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
}

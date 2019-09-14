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
            
            if let ingredientAmount = self.ingredient?.amount, let ingredientMeasure = self.ingredient?.measurementType {
                self.measureAmountLbl.text = "\(ingredientAmount) \(ingredientMeasure)"
            }
            
            // enable visibility of 'packed' label
            self.checkMarkView.isHidden = self.ingredient?.isPacked == true ? false : true
        }
    }
    
    let label = UILabel()
    let checkMarkView = UILabel()
    let measureAmountLbl = UILabel()
    let ingredientImg = UIImageView()
    
    private func setup() {
        self.backgroundColor = .yellow
        self.selectionStyle = .none
        self.addMeasureAmount()
        self.addLabel()
        self.addCheckMarkView()
    }
    
    private func addMeasureAmount() {
        self.measureAmountLbl.font = UIFont.fontCoolvetica?.withSize(10)
        self.addSubview(self.measureAmountLbl)
        self.measureAmountLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.measureAmountLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.measureAmountLbl.heightAnchor.constraint(equalToConstant: 15),
            self.measureAmountLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.measureAmountLbl.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2)
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
            self.label.bottomAnchor.constraint(equalTo: self.measureAmountLbl.topAnchor, constant: -5)
        ])
    }
    
    private func addCheckMarkView() {
        self.checkMarkView.font = UIFont.fontCoolvetica?.withSize(15)
        self.checkMarkView.isHidden = true
        self.checkMarkView.backgroundColor = UIColor.black
        self.checkMarkView.alpha = 0.7
        self.checkMarkView.textColor = .white
        self.checkMarkView.text = "Ingredient Packed!"
        self.checkMarkView.textAlignment = .center
        self.checkMarkView.layer.cornerRadius = 5
        self.checkMarkView.clipsToBounds = true
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
        self.checkMarkView.isHidden = self.ingredient?.isPacked == true ? false : true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
}

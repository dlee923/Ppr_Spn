//
//  IngredientsPrepTableViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/12/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class IngredientsPrepCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    
    var ingredient: Ingredients? {
        didSet {
            // set ingredient name
            self.label.text = self.ingredient?.name
            
            // set measurement amount
            if let ingredientAmount = self.ingredient?.amount, let ingredientMeasure = self.ingredient?.measurementType {
                self.measureAmountLbl.text = "\(ingredientAmount.clean) \(ingredientMeasure)"
            }
            
            // set ingredient image
            self.ingredientImg.image = self.ingredient?.image
            
            // enable visibility of 'packed' label
            self.checkMarkView.isHidden = self.ingredient?.isPacked == true ? false : true
        }
    }
    
    let label = UILabel()
    let checkMarkView = UIView()
    let measureAmountLbl = UILabel()
    let ingredientImg = UIImageView()
    
    private func setup() {
        self.backgroundColor = UIColor.themeColor1
        self.label.numberOfLines = 2
        self.addIngredientImage()
        self.addMeasureAmount()
        self.addLabel()
        self.addCheckMarkView()
    }
    
    private func addIngredientImage() {
        self.addSubview(self.ingredientImg)
        
        // add default image
        self.ingredientImg.image = UIImage(named: "ingredients_hf.png")?.withRenderingMode(.alwaysTemplate)
        self.ingredientImg.tintColor = UIColor.themeColor4
            
        self.ingredientImg.contentMode = .scaleAspectFit
        self.ingredientImg.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.ingredientImg.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35),
            self.ingredientImg.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.ingredientImg.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.ingredientImg.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
    }
    
    private func addMeasureAmount() {
        self.measureAmountLbl.font = UIFont.fontSunflower?.withSize(15)
        self.measureAmountLbl.textColor = UIColor.themeColor2
        self.addSubview(self.measureAmountLbl)
        self.measureAmountLbl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.measureAmountLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.measureAmountLbl.topAnchor.constraint(equalTo: self.ingredientImg.bottomAnchor),
            self.measureAmountLbl.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.measureAmountLbl.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35)
        ])
    }
    
    private func addLabel() {
        self.label.font = UIFont.fontCoolvetica?.withSize(10)
        self.label.textColor = UIColor.themeColor2
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.label.topAnchor.constraint(equalTo: self.measureAmountLbl.bottomAnchor),
            self.label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5)
        ])
    }
    
    private func addCheckMarkView() {
        self.checkMarkView.isHidden = true
        self.checkMarkView.backgroundColor = UIColor.themeColor4
        self.checkMarkView.layer.cornerRadius = 20
        self.checkMarkView.clipsToBounds = true
        self.addSubview(self.checkMarkView)
        
        self.checkMarkView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.checkMarkView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.checkMarkView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.checkMarkView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.checkMarkView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5)
        ])
        
        let checkMarkImage = UIImageView(image: UIImage(named: "checkmark")?.withRenderingMode(.alwaysTemplate))
        checkMarkImage.tintColor = UIColor.themeColor1
        self.checkMarkView.addSubview(checkMarkImage)
        
        checkMarkImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMarkImage.centerXAnchor.constraint(equalTo: self.checkMarkView.centerXAnchor),
            checkMarkImage.centerYAnchor.constraint(equalTo: self.checkMarkView.centerYAnchor),
            checkMarkImage.widthAnchor.constraint(equalTo: self.checkMarkView.widthAnchor, multiplier: 0.5),
            checkMarkImage.heightAnchor.constraint(equalTo: self.checkMarkView.heightAnchor, multiplier: 0.5)
        ])
    }
    
    func isPackedFunction() {
        // enable visibility of 'packed' label
        self.checkMarkView.isHidden = self.ingredient?.isPacked == true ? false : true
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

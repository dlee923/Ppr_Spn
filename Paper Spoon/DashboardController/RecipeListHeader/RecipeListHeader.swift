//
//  RecipeListHeader.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RecipeListHeader: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        self.addBrandPickerView()
        self.addHeaderLabel()
    }
    
    var brandPickerViewHeight: CGFloat = 120
    let headerLabel = UILabel()
    let brandPickerView = BrandPickerView()
    var brands: [Brand]? {
        didSet {
            self.brandPickerView.brands = self.brands
        }
    }
    
    private func addHeaderLabel() {
        self.headerLabel.font = UIFont.fontSunflower?.withSize(30)
        self.headerLabel.text = "Choose Recipes:"
        self.addSubview(self.headerLabel)
        
        self.headerLabel.translatesAutoresizingMaskIntoConstraints = false
        let leadingAnchorConstant = ((self.frame.height - brandPickerViewHeight)/2)
        NSLayoutConstraint.activate([
            self.headerLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.headerLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.headerLabel.trailingAnchor.constraint(equalTo: self.brandPickerView.leadingAnchor, constant: leadingAnchorConstant),
            self.headerLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            ])
    }
    
    private func addBrandPickerView() {
        self.addSubview(self.brandPickerView)
        self.brandPickerView.translatesAutoresizingMaskIntoConstraints = false
        let trailingAnchorConstant = ((self.frame.height - brandPickerViewHeight)/2)
        NSLayoutConstraint.activate([
            self.brandPickerView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.brandPickerView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: trailingAnchorConstant),
            self.brandPickerView.heightAnchor.constraint(equalToConstant: brandPickerViewHeight),
            self.brandPickerView.widthAnchor.constraint(equalToConstant: self.frame.height)
        ])
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.setup()
    }
    
}


struct Brand {
    var name: BrandType
    var image: UIImage
}

enum BrandType {
    case HelloFresh
    case BlueApron
    case HomeChef
    case EveryPlate
    case Plated
    case PurpleCarrot
}

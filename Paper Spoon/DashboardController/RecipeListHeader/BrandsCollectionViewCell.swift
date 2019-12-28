//
//  BrandPickerViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class BrandsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    var brand: Brand? {
        didSet {
            self.addBrandImage()
        }
    }
    
    var brandImage = UIImageView()
    
    private func addBrandImage() {
        self.brandImage.image = brand?.image
        self.brandImage.contentMode = .scaleAspectFit
        self.addSubview(self.brandImage)
        
        self.brandImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.brandImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1),
            self.brandImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1),
            self.brandImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.brandImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

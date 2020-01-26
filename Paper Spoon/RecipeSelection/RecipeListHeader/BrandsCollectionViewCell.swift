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
        self.brandImage.image = brand?.image.withRenderingMode(.alwaysTemplate)
        self.brandImage.tintColor = UIColor.themeColor1
        self.brandImage.contentMode = .scaleAspectFit
        self.brandImage.addShadow(path: nil, color: UIColor.black, offset: CGSize(width: 2, height: 2), radius: 2.0, opacity: 1.0)
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

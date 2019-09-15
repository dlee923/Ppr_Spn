//
//  BrandPickerViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class BrandPickerViewCell: UIView {
    
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
            self.brandImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.brandImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.brandImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.brandImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

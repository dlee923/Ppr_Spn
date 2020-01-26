//
//  MenuOptionListHeader.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/1/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class MenuOptionListHeader: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addBrandImage()
    }
    
    var brandImage = UIImageView()
    var headerLabel = UILabel()
    var brand: Brand? {
        didSet {
            self.brandImage.image = brand?.largeImage
        }
    }
    
    private func addBrandImage() {
        self.brandImage.contentMode = .scaleAspectFit
        self.addSubview(self.brandImage)
        
        self.brandImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.brandImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            self.brandImage.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.brandImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.4),
            self.brandImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
        ])
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

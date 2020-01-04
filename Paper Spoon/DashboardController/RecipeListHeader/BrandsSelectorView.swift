//
//  BrandsSelectorView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class BrandsSelectorView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addImage()
    }
    
    var image = UIImageView()
    
    private func addImage() {
        self.addSubview(self.image)
        self.image.image = UIImage(named: "selector")?.withRenderingMode(.alwaysTemplate)
        self.image.tintColor = UIColor.color2
        self.image.contentMode = .scaleAspectFit
        self.image.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.image.topAnchor.constraint(equalTo: self.topAnchor),
            self.image.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.image.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.image.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

//
//  optionsCountView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/10/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class OptionsCountView: UIView {
    
    var optionsCounter = UIPageControl()
    var textCounter = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    private func setup() {
        self.addSubview(optionsCounter)
        self.addSubview(textCounter)
        textCounter.font = UIFont.fontSunflower?.withSize(15)
        textCounter.textColor = UIColor.themeColor1
        textCounter.backgroundColor = UIColor.themeColor2
        
        optionsCounter.translatesAutoresizingMaskIntoConstraints = false
        textCounter.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            optionsCounter.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            optionsCounter.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            optionsCounter.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            optionsCounter.topAnchor.constraint(equalTo: self.textCounter.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            textCounter.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            textCounter.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            textCounter.topAnchor.constraint(equalTo: self.topAnchor),
            textCounter.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.75)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

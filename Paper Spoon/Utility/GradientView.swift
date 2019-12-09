//
//  GradientView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/8/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    var gradient = CAGradientLayer()
    
    func setup() {
        self.backgroundColor = .clear
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.themeColor1.cgColor
        let color0 = UIColor.themeColor1.cgColor
        self.gradient.colors = [colorTop, colorBottom, color0]
        self.gradient.locations = [0.0, 0.95, 1.0]
        
        self.layer.addSublayer(gradient)
        gradient.frame.size = self.frame.size
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

}

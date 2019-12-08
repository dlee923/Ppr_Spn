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
        print("add gradient")
        self.backgroundColor = .clear
        let colorTop = UIColor.clear.cgColor
        let colorBottom = UIColor.themeColor1.cgColor
        self.gradient.colors = [colorTop, colorBottom]
        self.gradient.locations = [0.0, 1.0]
        
        self.layer.addSublayer(gradient)
        gradient.frame.size = self.frame.size
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }

}

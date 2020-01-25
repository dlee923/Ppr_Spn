//
//  GradientView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/8/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class GradientView: UIView {
    
    convenience init(frame: CGRect, colorTop: CGColor, colorBottom: CGColor) {
        self.init(frame: frame)
        self.setup(colorTop: colorTop, colorBottom: colorBottom)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupDefault()
    }
    
    var gradient = CAGradientLayer()
    
    let colorTop = UIColor.clear.cgColor
    let colorBottom = UIColor.themeColor1.cgColor
    let color0 = UIColor.themeColor1.cgColor
    
    func setupDefault() {
        self.gradient.colors = [colorTop, colorBottom, color0]
        self.gradient.locations = [0.4, 0.95, 1.0]
        
        self.setGradientLayer()
    }
    
    func setup(colorTop: CGColor, colorBottom: CGColor) {
        self.gradient.colors = [colorTop, colorBottom]
        self.gradient.startPoint = CGPoint(x: 0.5, y: 0.5)
        self.gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    }
    
    func setGradientLayer() {
        self.layer.addSublayer(gradient)
        gradient.frame.size = self.frame.size
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupDefault()
    }

}

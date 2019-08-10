//
//  Extensions.swift
//  HF Test
//
//  Created by Daniel Lee on 5/11/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

extension UIStackView {
    // Simplify adding stackview parameters
    func stackProperties(axis: NSLayoutConstraint.Axis, spacing: CGFloat, alignment: UIStackView.Alignment, distribution: UIStackView.Distribution) {
        
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
}

extension UIView {
    // Simplify adding shadow parameters
    func addShadow(path: UIBezierPath, color: UIColor, offset: CGSize, radius: CGFloat, opacity: Float) {
        self.layer.shadowPath = path.cgPath
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowRadius = radius
        self.layer.shadowOpacity = opacity
    }
    
}

extension String {
    // Text validation to block invalid submissions
    func validateAlphaNumericSymbol() -> Bool {
        let result = self.range(of: "[^a-zA-Z0-9!@#$%\\^&*()]", options: .regularExpression)
        return result != nil ? false : true
    }
    
    func validateEmail() -> Bool {
        let result = self.range(of: "^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$", options: .regularExpression)
        return result != nil ? true : false
    }

}

extension UIAlertController {
    // Helper method to creating alert prompts
    func simpleAlertPrompt(title: String, message: String, preferredStyle: UIAlertController.Style, actionTitle: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        if let actionTitleInput = actionTitle {
            let action = UIAlertAction(title: actionTitleInput, style: .default, handler: nil)
            alert.addAction(action)
        }
        return alert
    }
}

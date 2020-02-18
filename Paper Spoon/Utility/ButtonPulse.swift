//
//  ButtonPulse.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 2/18/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

extension UIView {
    
    func addPulseLayer(frame: CGRect, pulseColor: UIColor) -> CAShapeLayer {
        
        // create shape of layer
        let pulsePath = UIBezierPath(roundedRect: frame, cornerRadius: 5)
        
        // create animatable layer
        let pulseLayer = CAShapeLayer()
        
        // assign shape to layer + size and color properties
        pulseLayer.path = pulsePath.cgPath
        pulseLayer.fillColor = pulseColor.cgColor
        pulseLayer.position = self.center
        return pulseLayer
        
    }
    
    func startPulseAnimation(pulseLayer: CAShapeLayer) {
        
        let pulseAnimation = CABasicAnimation()
        pulseAnimation.toValue = 1.2
        pulseAnimation.duration = 0.8
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        pulseLayer.add(pulseAnimation, forKey: "pulse")
        
    }
    
}

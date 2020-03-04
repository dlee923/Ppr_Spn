//
//  ButtonPulse.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 2/18/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

var pulseLayer: CAShapeLayer?

extension UIView {
    
    func addPulseLayer(frame: CGRect, pulseColor: UIColor) {
        
        // create shape of layer
        let pulsePath = UIBezierPath(roundedRect: frame, cornerRadius: 10)
        
        // create animatable layer
        pulseLayer = CAShapeLayer()
        // need to set bounds in order to pulse from center
        pulseLayer?.bounds = CGRect(x: 5, y: -3.5, width: frame.width, height: frame.height)
        
        // assign shape to layer + size and color properties
        pulseLayer?.path = pulsePath.cgPath
        pulseLayer?.fillColor = pulseColor.cgColor
        pulseLayer?.position = self.center
        
        startPulseAnimation()
        
        self.layer.insertSublayer(pulseLayer ?? CAShapeLayer(), at: 0)
    }
    
    func startPulseAnimation() {
        
        let pulseAnimation = CABasicAnimation(keyPath: "transform.scale")
        pulseAnimation.toValue = 1.05
        pulseAnimation.duration = 0.9
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = Float.infinity
        pulseLayer?.add(pulseAnimation, forKey: "pulse")
        
    }
    
}

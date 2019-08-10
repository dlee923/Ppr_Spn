//
//  ActivityIndicator.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/3/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    
    let introBlankView = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height))
    
    // Activity indicator method
    func activityInProgress() {
        // Add background view to prevent user interactions
        introBlankView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        UIApplication.shared.keyWindow?.addSubview(introBlankView)
        
        // Add activity indicator on top of blank layer
        self.isHidden = false
        UIApplication.shared.keyWindow?.addSubview(self)
        self.backgroundColor = .black
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.centerYAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.widthAnchor, multiplier: 0.25).isActive = true
        self.heightAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.widthAnchor, multiplier: 0.25).isActive = true
        
        // Start animating indicator
        self.startAnimating()
        print("start")
    }
    
    func activityEnded() {
        // Remove view preventing user interaction
        UIView.animate(withDuration: 0.35, animations: {
            self.introBlankView.alpha = 0.0
        }) { (_) in
            self.introBlankView.removeFromSuperview()
            self.stopAnimating()
            self.isHidden = true
            self.removeFromSuperview()
            print("finished")
        }
    }
    
}

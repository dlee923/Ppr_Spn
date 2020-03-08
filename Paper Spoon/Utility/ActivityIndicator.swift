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
    
    var progressLabel = UILabel()
    var progressCount: Int?
    
    // Activity indicator method
    func activityInProgress() {
        // Add background view to prevent user interactions
        introBlankView.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        UIApplication.shared.keyWindow?.addSubview(introBlankView)
        
        // Add activity indicator on top of blank layer
        self.isHidden = false
        self.style = .white
        self.backgroundColor = .black
        self.layer.cornerRadius = 10
        
        UIApplication.shared.keyWindow?.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.centerXAnchor).isActive = true
        self.centerYAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.centerYAnchor).isActive = true
        self.widthAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.widthAnchor, multiplier: 0.25).isActive = true
        self.heightAnchor.constraint(equalTo: UIApplication.shared.keyWindow!.widthAnchor, multiplier: 0.25).isActive = true
        
        // Add progress label on top of blank layer
        progressLabel.layer.cornerRadius = 10
        progressLabel.backgroundColor = .black
        progressLabel.textColor = UIColor.themeColor4
        progressLabel.textAlignment = .center
        progressLabel.clipsToBounds = true
        progressLabel.numberOfLines = 4
        progressLabel.font = UIFont.fontSunflower?.withSize(10)
        progressLabel.text = "Downloading..."

        self.addSubview(progressLabel)
        progressLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.progressLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.progressLabel.heightAnchor.constraint(equalToConstant: 50),
            self.progressLabel.widthAnchor.constraint(equalTo: self.widthAnchor),
            self.progressLabel.bottomAnchor.constraint(equalTo: self.topAnchor, constant: 15)
        ])
        
        // Start animating indicator
        self.startAnimating()
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
        }
    }
    
}

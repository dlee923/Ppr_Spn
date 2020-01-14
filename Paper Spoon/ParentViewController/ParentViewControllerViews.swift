//
//  ParentViewControllerViews.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/13/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

extension ParentViewController {
    
    internal func addGradientBackground() {
        let colorBottom = UIColor(red: 190/255, green: 190/255, blue: 190/255, alpha: 1.0)
        let background = GradientView(frame: self.view.frame, colorTop: UIColor.clear.cgColor, colorBottom: colorBottom.cgColor)
        self.view.insertSubview(background, at: 0)
        background.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            background.topAnchor.constraint(equalTo: self.view.topAnchor),
            background.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            background.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            background.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
        
    }
    
    internal func addSplashImageView() {
        // control depth of splash image
        let splashRange: CGFloat = 0.3
        
        self.splashImageView = SplashImageView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: (self.view.bounds.height) * splashRange + 10))
        guard let splashImageView = self.splashImageView else { return }
        self.view.insertSubview(splashImageView, at: 0)
        splashImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            splashImageView.topAnchor.constraint(equalTo: self.view.topAnchor),
            splashImageView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            splashImageView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: splashRange),
            splashImageView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor)
        ])
    }
    
}

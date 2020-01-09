//
//  SplashImageView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/3/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class SplashImageView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSplashImage()
        addGradientView()
    }
    
    let splashImage = UIImageView()
    lazy var gradientView = GradientView(frame: self.frame)
    
    private func addSplashImage() {
        self.splashImage.image = UIImage(named: "splash1")
        self.splashImage.contentMode = .scaleAspectFill
        self.addSubview(self.splashImage)
        self.splashImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.splashImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.splashImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.splashImage.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.splashImage.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    private func addGradientView() {
        self.addSubview(self.gradientView)
        self.gradientView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.gradientView.topAnchor.constraint(equalTo: self.topAnchor),
            self.gradientView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.gradientView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            self.gradientView.leadingAnchor.constraint(equalTo: self.leadingAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

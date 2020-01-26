//
//  RecipeIngredientButton.swift
//  HF Test
//
//  Created by Daniel Lee on 5/11/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class RecipeCellButton: UIButton {
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.setup(color: color)
    }
    
    //MARK: - Setup methods
    private func setup(color: UIColor) {
        self.backgroundColor = color
        self.layer.cornerRadius = self.frame.width / 2
        self.clipsToBounds = true
    }
    
    //MARK: - Override touch methods to animate interaction
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseOut, animations: {
            self.transform = CGAffineTransform(scaleX: 1.18, y: 1.18)
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: {
            self.transform = CGAffineTransform.identity
        }, completion: nil)
        super.touchesEnded(touches, with: event)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

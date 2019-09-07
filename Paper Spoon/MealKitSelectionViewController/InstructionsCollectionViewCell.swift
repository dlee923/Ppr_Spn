//
//  InstructionsCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/7/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class InstructionsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        
    }
    
    let instructionsTextField = UITextField()
    let instructionsImage = UIImageView()
    
    private func addInstructionsImage() {
        self.instructionsImage.backgroundColor = .purple
        self.addSubview(self.instructionsImage)
        self.instructionsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.instructionsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.instructionsImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.instructionsImage.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.instructionsImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35)
        ])
    }
    
    private func addInstructionsTextfield() {
        self.instructionsTextField.backgroundColor = .yellow
        self.addSubview(self.instructionsTextField)
        self.instructionsTextField.translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

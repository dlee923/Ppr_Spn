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
        self.addInstructionsImage()
        self.addInstructionsTextView()
    }
    
    let instructionsTextView = UITextView()
    let instructionsImage = UIImageView()
    var instructions: String? { didSet { self.instructionsTextView.text = instructions } }
    var instructionsHTML: NSAttributedString? { didSet { self.instructionsTextView.attributedText = instructionsHTML } }
    
    private func addInstructionsImage() {
        self.addSubview(self.instructionsImage)
        self.instructionsImage.contentMode = .scaleAspectFill
        self.instructionsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.instructionsImage.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.instructionsImage.topAnchor.constraint(equalTo: self.topAnchor),
            self.instructionsImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.85, constant: -5),
            self.instructionsImage.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.35)
        ])
    }
    
    private func addInstructionsTextView() {
        self.instructionsTextView.textColor = UIColor.themeColor2
        self.instructionsTextView.backgroundColor = UIColor.themeColor1
        self.instructionsTextView.isEditable = false
        self.instructionsTextView.font = UIFont.fontOldSansBlack?.withSize(20)
        
        self.addSubview(self.instructionsTextView)
        self.instructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.instructionsTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.instructionsTextView.topAnchor.constraint(equalTo: self.instructionsImage.bottomAnchor),
            self.instructionsTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.instructionsTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

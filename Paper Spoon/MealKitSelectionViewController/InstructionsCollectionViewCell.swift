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
    
    private func addInstructionsTextView() {
        self.instructionsTextView.textColor = .red
        self.instructionsTextView.backgroundColor = .yellow
        self.instructionsTextView.isEditable = false
        self.instructionsTextView.font = UIFont.fontCoolvetica?.withSize(20)
        
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

//
//  InstructionsImgCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class InstructionsImgCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    var stepLabelNumber = UILabel()
    var instructionImage = UIImageView()
    
    private func addStepNumberLabel() {
        self.addSubview(self.stepLabelNumber)
        self.stepLabelNumber.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.instructionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.instructionImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.instructionImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.instructionImage.trailingAnchor.constraint(equalTo: self.instructionImage.leadingAnchor, constant: 5)
        ])
    }
    
    private func addInstructionImage() {
        self.addSubview(self.instructionImage)
        self.instructionImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.instructionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5),
            self.instructionImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.instructionImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5),
            self.instructionImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

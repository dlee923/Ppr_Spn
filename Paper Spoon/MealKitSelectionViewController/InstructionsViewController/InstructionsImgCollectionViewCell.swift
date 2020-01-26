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
        self.backgroundColor = UIColor.themeColor1

        self.addInstructionImage()
        self.addStepNumberLabel()
    }
    
    var stepLabelNumber = UILabel()
    var instructionImage = UIImageView()
    
    private func addStepNumberLabel() {
        self.addSubview(self.stepLabelNumber)
        self.stepLabelNumber.font = UIFont.fontSunflower?.withSize(10)
        self.stepLabelNumber.textColor = UIColor.themeColor1
        self.stepLabelNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stepLabelNumber.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            self.stepLabelNumber.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2),
            self.stepLabelNumber.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            self.stepLabelNumber.trailingAnchor.constraint(equalTo: self.instructionImage.leadingAnchor, constant: -2)
        ])
    }
    
    private func addInstructionImage() {
        self.addSubview(self.instructionImage)
        self.instructionImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.instructionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            self.instructionImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            self.instructionImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            self.instructionImage.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

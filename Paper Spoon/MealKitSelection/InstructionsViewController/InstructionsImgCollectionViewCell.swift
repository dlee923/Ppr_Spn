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
        self.instructionImage.addSubview(self.stepLabelNumber)
        self.stepLabelNumber.font = UIFont.fontSunflower?.withSize(20)
        self.stepLabelNumber.textAlignment = .center
        self.stepLabelNumber.textColor = UIColor.themeColor1
        self.stepLabelNumber.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.stepLabelNumber.centerXAnchor.constraint(equalTo: self.instructionImage.centerXAnchor),
            self.stepLabelNumber.centerYAnchor.constraint(equalTo: self.instructionImage.centerYAnchor),
            self.stepLabelNumber.heightAnchor.constraint(equalTo: self.instructionImage.heightAnchor),
            self.stepLabelNumber.widthAnchor.constraint(equalTo: self.instructionImage.widthAnchor)
        ])
    }
    
    private func addInstructionImage() {
        self.addSubview(self.instructionImage)
        self.instructionImage.contentMode = .scaleAspectFill
        self.instructionImage.layer.cornerRadius = 5
        self.instructionImage.clipsToBounds = true
        self.instructionImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.instructionImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            self.instructionImage.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -2),
            self.instructionImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -2),
            self.instructionImage.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 2)
        ])
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

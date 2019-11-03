//
//  CreateNewMenuPrompt.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/27/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class NewMenuPrompt: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    private func setup() {
        self.backgroundColor = .red
        self.addMenuTitle()
        self.addMenuNameField()
    }
    
    // MARK:  UI Elements
    let menuTitle = UILabel()
    let menuNameField = UITextField()
    
    private func addMenuTitle() {
        self.menuTitle.font = UIFont.fontSunflower?.withSize(20)
        self.menuTitle.textColor = UIColor.color2
        
        self.addSubview(self.menuTitle)
        self.menuTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.menuTitle.topAnchor.constraint(equalTo: self.topAnchor),
            self.menuTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.menuTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.menuTitle.bottomAnchor.constraint(equalTo: self.centerYAnchor)
        ])
    }
    
    private func addMenuNameField() {
        self.addSubview(self.menuNameField)
        self.menuNameField.placeholder = "Enter name for menu!"
        self.menuNameField.font = UIFont.fontBebas?.withSize(20)
        
        self.menuNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.menuNameField.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.menuNameField.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.menuNameField.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.menuNameField.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}

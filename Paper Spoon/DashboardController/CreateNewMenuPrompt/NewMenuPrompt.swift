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
        self.addCreateBtn()
        self.addNoThanksBtn()
    }
    
    // MARK:  UI Elements
    let menuTitle = UILabel()
    let menuNameField = UITextField()
    let noThanksBtn = UIButton()
    let createBtn = UIButton()
    
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
        self.menuNameField.placeholder = "Enter name for menu"
        self.menuNameField.font = UIFont.fontBebas?.withSize(20)
        self.menuNameField.textAlignment = .center
        self.menuNameField.backgroundColor = UIColor.white.withAlphaComponent(0.3)
        
        self.menuNameField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.menuNameField.topAnchor.constraint(equalTo: self.centerYAnchor),
            self.menuNameField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            self.menuNameField.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5),
            self.menuNameField.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addCreateBtn() {
        self.addSubview(self.createBtn)
        self.createBtn.backgroundColor = UIColor.color2
        self.createBtn.layer.cornerRadius = 5
        self.createBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(15)
        self.createBtn.setTitle("Submit", for: .normal)
        self.createBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.createBtn.topAnchor.constraint(equalTo: self.menuNameField.bottomAnchor),
            self.createBtn.leadingAnchor.constraint(equalTo: self.menuNameField.leadingAnchor),
            self.createBtn.trailingAnchor.constraint(equalTo: self.menuNameField.trailingAnchor, constant: -70),
            self.createBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addNoThanksBtn() {
        self.addSubview(self.noThanksBtn)
        self.noThanksBtn.titleLabel?.font = UIFont.fontCoolvetica?.withSize(10)
        self.noThanksBtn.titleLabel?.textAlignment = .right
        self.noThanksBtn.setTitle("No Thanks", for: .normal)
        self.noThanksBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noThanksBtn.topAnchor.constraint(equalTo: self.menuNameField.bottomAnchor),
            self.noThanksBtn.leadingAnchor.constraint(equalTo: self.createBtn.trailingAnchor, constant: 5),
            self.noThanksBtn.trailingAnchor.constraint(equalTo: self.menuNameField.trailingAnchor),
            self.noThanksBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}

extension NewMenuPrompt: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        <#code#>
    }
}

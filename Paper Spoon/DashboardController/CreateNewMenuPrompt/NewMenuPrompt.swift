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
        self.backgroundColor = UIColor.themeColor1
        self.addBackgroundImageView()
        self.addMenuTitle()
        self.addMenuNameField()
        self.addInstructionsTextView()
        self.addCreateBtn()
        self.addNoThanksBtn()
    }
    
    // MARK:  UI Elements
    let backgroundImageView = UIImageView()
    let menuTitle = UILabel()
    let instructionsTextView = UILabel()
    let menuNameField = UITextField()
    let noThanksBtn = UIButton()
    let createBtn = UIButton()
    
    // MARK:  Delegates
    var brandDashboardControllerTransitionsDelegate: BrandDashboardControllerTransitionsDelegate?
    
    private func addBackgroundImageView() {
        self.backgroundImageView.image = UIImage(named: "backgroundImg")
        self.backgroundImageView.alpha = 0.25
        self.backgroundImageView.contentMode = .scaleAspectFill
        
        self.addSubview(self.backgroundImageView)
        self.backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.backgroundImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.backgroundImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.backgroundImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.backgroundImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
    
    private func addMenuTitle() {
        self.menuTitle.font = UIFont.fontSunflower?.withSize(50)
        self.menuTitle.textColor = UIColor.color2
        self.menuTitle.connect(with: self.menuNameField)
        
        self.addSubview(self.menuTitle)
        self.menuTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.menuTitle.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor),
            self.menuTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.menuTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5)
        ])
        self.menuTitle.sizeToFit()
    }
    
    private func addInstructionsTextView() {
        self.addSubview(self.instructionsTextView)
        self.instructionsTextView.font = UIFont.fontCoolvetica?.withSize(15)
        self.instructionsTextView.textAlignment = .center
        self.instructionsTextView.numberOfLines = 4
        self.instructionsTextView.text = "Let's create a menu that we can\nsave and use at a later date!\n\n(ie. Monday Dinners, etc.)"
        
        self.instructionsTextView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.instructionsTextView.topAnchor.constraint(equalTo: self.menuTitle.bottomAnchor),
            self.instructionsTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.instructionsTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.instructionsTextView.bottomAnchor.constraint(equalTo: self.menuNameField.topAnchor)
        ])
        
    }
    
    private func addMenuNameField() {
        self.addSubview(self.menuNameField)
        self.menuNameField.placeholder = "Enter name for menu"
        self.menuNameField.font = UIFont.fontBebas?.withSize(20)
        self.menuNameField.textAlignment = .center
        self.menuNameField.backgroundColor = UIColor.black.withAlphaComponent(0.1)
        
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
        self.createBtn.addTarget(self, action: #selector(createBtnAction), for: .touchUpInside)
        
        self.createBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.createBtn.topAnchor.constraint(equalTo: self.menuNameField.bottomAnchor, constant: 10),
            self.createBtn.leadingAnchor.constraint(equalTo: self.menuNameField.leadingAnchor),
            self.createBtn.trailingAnchor.constraint(equalTo: self.menuNameField.trailingAnchor, constant: -70),
            self.createBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func addNoThanksBtn() {
        self.addSubview(self.noThanksBtn)
        self.noThanksBtn.titleLabel?.font = UIFont.fontCoolvetica?.withSize(10)
        self.noThanksBtn.setTitleColor(.themeColor2, for: .normal)
        self.noThanksBtn.contentHorizontalAlignment = .right
        self.noThanksBtn.setTitle("No Thanks", for: .normal)
        self.noThanksBtn.addTarget(self, action: #selector(noThanksBtnAction), for: .touchUpInside)
        
        self.noThanksBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.noThanksBtn.topAnchor.constraint(equalTo: self.menuNameField.bottomAnchor, constant: 10),
            self.noThanksBtn.leadingAnchor.constraint(equalTo: self.createBtn.trailingAnchor, constant: 5),
            self.noThanksBtn.trailingAnchor.constraint(equalTo: self.menuNameField.trailingAnchor),
            self.noThanksBtn.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    @objc private func noThanksBtnAction() {
        self.removeFromSuperview()
    }
    
    @objc private func createBtnAction() {
        self.brandDashboardControllerTransitionsDelegate?.transitionCompileIngredientsViewDelegateMethod()
        self.removeFromSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
   
}


extension UILabel {
    @objc func input(textField: UITextField) {
        self.text = textField.text
    }
    
    func connect(with textField: UITextField) {
        textField.addTarget(self, action: #selector(input(textField:)), for: .editingChanged)
    }
}

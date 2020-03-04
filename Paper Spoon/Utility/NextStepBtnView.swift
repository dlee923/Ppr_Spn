//
//  NextStepBtnView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 2/25/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import UIKit

class NextStepBtnView: UIView {

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setupCompileIngredientsBtn()
        self.addCompileIngredientsBtn()
        self.addFingerPointer()
        self.addBtnPulse()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCompileIngredientsBtn()
        self.addCompileIngredientsBtn()
        self.addFingerPointer()
        self.addBtnPulse()
    }
    
    var compileIngredientsBtn: NextStepBtn?
    let compileIngredientsBtnHeight: CGFloat = 0.06
    
    // MARK:  Animatable constraints - for use in animating finger movement
    var fingerTrailingAnchorClose: NSLayoutConstraint?
    var fingerTrailingAnchorFar: NSLayoutConstraint?
    
    
    internal func setupCompileIngredientsBtn() {
        self.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: (self.frame.height * self.compileIngredientsBtnHeight) * 0.85)
        self.bounds = CGRect(x: 0, y: 0, width: (self.frame.width * 0.5) - 5, height: self.frame.height)
        let btnFrame = CGRect.zero
        self.compileIngredientsBtn = NextStepBtn(frame: btnFrame, setTitle: "Create Shopping List!")
        self.compileIngredientsBtn?.titleLabel?.font = UIFont.fontSunflower?.withSize(12)
        self.compileIngredientsBtn?.titleLabel?.numberOfLines = 2
        self.compileIngredientsBtn?.titleLabel?.textAlignment = .center
        
        self.compileIngredientsBtn?.layer.cornerRadius = 10
    }
    
    internal func addCompileIngredientsBtn() {
        guard let compileIngredientsBtn = self.compileIngredientsBtn else { return }
        self.addSubview(compileIngredientsBtn)
        compileIngredientsBtn.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            compileIngredientsBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            compileIngredientsBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            compileIngredientsBtn.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.85),
            compileIngredientsBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5)
        ])
    }
    
    internal func addBtnPulse() {
        let frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height)
        self.addPulseLayer(frame: frame ?? CGRect.zero, pulseColor: UIColor.themeColor4)
    }
    
    internal func addFingerPointer() {
        guard let compileIngredientsBtn = self.compileIngredientsBtn else { return }
        let finger = UIImageView(image: UIImage(named: "hand"))
        finger.contentMode = .scaleAspectFit
        self.addSubview(finger)
        
        finger.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            finger.topAnchor.constraint(equalTo: self.topAnchor),
            finger.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            finger.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1)
        ])
        
        fingerTrailingAnchorClose = finger.trailingAnchor.constraint(equalTo: compileIngredientsBtn.leadingAnchor, constant: -15)
        fingerTrailingAnchorFar = finger.trailingAnchor.constraint(equalTo: compileIngredientsBtn.leadingAnchor, constant: -30)
        fingerTrailingAnchorClose?.isActive = true
    }
    

}

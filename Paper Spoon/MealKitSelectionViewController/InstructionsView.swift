//
//  InstructionsView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/7/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class InstructionsView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    var instructionsCollectionView: InstructionsCollectionView?
    var finishedCookingBtn = UIButton()
    var menuOption: MenuOption? {
        didSet {
            self.instructionsCollectionView?.recipe = self.menuOption?.recipe
        }
    }
    var dismissPopUpDelegate: DismissPopUpDelegate?
    
    private func setup() {
        self.backgroundColor = UIColor.themeColor1
        self.addFinishedCookingBtn()
        self.addInstructionsCollectionView()
    }
    
    private func addFinishedCookingBtn() {
        self.finishedCookingBtn.setTitle("Finished Cooking!", for: .normal)
        self.finishedCookingBtn.backgroundColor = UIColor.color2
        self.finishedCookingBtn.layer.cornerRadius = 5
        self.addSubview(self.finishedCookingBtn)
        
        self.finishedCookingBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.finishedCookingBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.finishedCookingBtn.heightAnchor.constraint(equalToConstant: 60),
            self.finishedCookingBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.finishedCookingBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.finishedCookingBtn.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
    }
    
    @objc private func dismiss() {
        self.dismissPopUpDelegate?.dismissPopup()
    }
    
    private func addInstructionsCollectionView() {
        self.instructionsCollectionView = InstructionsCollectionView(frame: self.frame)
        guard let instructionsCV = self.instructionsCollectionView else { return }
        self.addSubview(instructionsCV)
        
        instructionsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionsCV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            instructionsCV.topAnchor.constraint(equalTo: self.topAnchor),
            instructionsCV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            instructionsCV.bottomAnchor.constraint(equalTo: self.finishedCookingBtn.topAnchor, constant: -5)
        ])
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//
//  CompileIngredientsBtn.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 8/17/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class NextStepBtn: UIButton {
    
    init(frame: CGRect, setTitle: String) {
        super.init(frame: frame)
        self.setup(setTitle: setTitle)
    }
    
    private func setup(setTitle: String) {
        self.backgroundColor = UIColor.color5
        self.setTitle(setTitle, for: .normal)
        self.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.titleLabel?.textColor = UIColor.themeColor1
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

//
//  BrandPickerView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/14/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class BrandPickerView: UIPickerView, UIPickerViewDelegate, UIPickerViewDataSource {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    var brands: [Brand]?
    
    private func setup() {
        self.delegate = self
        self.dataSource = self
        self.transform = CGAffineTransform(rotationAngle: -90 * (.pi/180))
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.brands?.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        // remove pickerview selection lines
        pickerView.subviews[1].isHidden = true
        pickerView.subviews[2].isHidden = true
        
        let view = BrandPickerViewCell(frame: self.frame)
        view.brand = self.brands?[row]
        return view
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

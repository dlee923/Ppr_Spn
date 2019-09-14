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
        self.backgroundColor = .orange
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.brands?.count ?? 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

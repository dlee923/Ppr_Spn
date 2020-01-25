//
//  NumberFormatter.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 1/24/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import Foundation

extension Double {
    
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
    
}

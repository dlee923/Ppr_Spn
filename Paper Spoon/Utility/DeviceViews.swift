//
//  ViewParameters.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class DeviceViews {
    
    static let statusBarNavBarHeight: [Device.DeviceTypes : CGFloat] = [
        Device.DeviceTypes.iPhone5      : (20 + 44),
        Device.DeviceTypes.iPhone8      : (20 + 44),
        Device.DeviceTypes.iPhone8Plus  : (20 + 44),
        Device.DeviceTypes.iPhoneXs     : (44 + 44),
        Device.DeviceTypes.iPhoneXsPlus : (44 + 44)
    ]
    
    static let imageWidthMultiplier: [Device.DeviceTypes : CGFloat] = [
        Device.DeviceTypes.iPhone5      : 0.50,
        Device.DeviceTypes.iPhone8      : 0.55,
        Device.DeviceTypes.iPhone8Plus  : 0.60,
        Device.DeviceTypes.iPhoneXs     : 0.65,
        Device.DeviceTypes.iPhoneXsPlus : 0.70
    ]
    
    static let BtnSizeMultiplier: [Device.DeviceTypes : CGFloat] = [
        Device.DeviceTypes.iPhone5      : 0.14,
        Device.DeviceTypes.iPhone8      : 0.13,
        Device.DeviceTypes.iPhone8Plus  : 0.13,
        Device.DeviceTypes.iPhoneXs     : 0.13,
        Device.DeviceTypes.iPhoneXsPlus : 0.13
    ]
    
    static let recipeDescriptionFontSize: [Device.DeviceTypes : CGFloat] = [
        Device.DeviceTypes.iPhone5      : 13,
        Device.DeviceTypes.iPhone8      : 14,
        Device.DeviceTypes.iPhone8Plus  : 15,
        Device.DeviceTypes.iPhoneXs     : 15,
        Device.DeviceTypes.iPhoneXsPlus : 15
    ]

    static let nutritionFontSize: [Device.DeviceTypes : CGFloat] = [
        Device.DeviceTypes.iPhone5      : 13,
        Device.DeviceTypes.iPhone8      : 13,
        Device.DeviceTypes.iPhone8Plus  : 13,
        Device.DeviceTypes.iPhoneXs     : 13,
        Device.DeviceTypes.iPhoneXsPlus : 13
    ]
    
}

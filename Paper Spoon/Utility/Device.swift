//
//  Device.swift
//  HF Test
//
//  Created by Daniel Lee on 5/13/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class Device: NSObject {
    
    // MARK: - Initialization
    override init() {
        super.init()
    }
    
    // MARK: - Static Properties
    static let current = Device()
    
    // MARK: - Mutable Properties
    var name: String?
    var model: String?
    var deviceType: DeviceTypes {
        let screenHeight = UIScreen.main.bounds.size.height
        switch screenHeight {
        case 0..<667:
            return .iPhone5
        case 667..<735:
            return .iPhone8
        case 736..<811:
            return .iPhone8Plus
        case 812..<895:
            return .iPhoneXs
        case 896..<2000:
            return .iPhoneXsPlus
        default:
            return .other
        }
    }
    
    func retrieveDeviceDetails() {
        let device = UIDevice.current
        name = device.name
        model = device.model
        print("============ Device Details ============")
        print("      Name:\(name ?? "")")
        print("   Product:\(model ?? "")")
        print("DeviceType:\(deviceType.self)")
        print("========================================")
    }
    
    // MARK: - Device Enum
    enum DeviceTypes {
        case iPhone5
        case iPhone6
        case iPhone6Plus
        case iPhone7
        case iPhone7Plus
        case iPhone8
        case iPhone8Plus
        case iPhoneXs
        case iPhoneXsPlus
        case other
    }
    
    
}

//
//  SaveModel.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 3/7/20.
//  Copyright © 2020 DLEE. All rights reserved.
//

import Foundation

class SaveModel {
    
    func loadData(variable: String) -> Any {
        if let object = UserDefaults.standard.value(forKey: variable) {
            return object
        }
        return ""
    }
    
    func loadObject(variable: String) -> Any {
        if let object = UserDefaults.standard.object(forKey: variable) as? Data {
            if let objectToReturn = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(object) as? [MenuOption] {
                return objectToReturn
            }
        }
        return ""
    }

}

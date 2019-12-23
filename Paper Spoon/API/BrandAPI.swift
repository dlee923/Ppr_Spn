//
//  BrandAPI.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 12/15/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import Foundation

class BrandAPI: NSObject {
    
    func retrieveRecipeInfo(urlString: String, completion: @escaping ((Recipe) -> ()) ) {}
    func retrieveMenuOptions(completion: ((Any) -> ())? ) {}
    
}

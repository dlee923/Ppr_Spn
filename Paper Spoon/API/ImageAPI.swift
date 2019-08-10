//
//  ImageAPI.swift
//  HF Test
//
//  Created by Daniel Lee on 5/11/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class ImageAPI: NSObject {
    
    static let shared = ImageAPI()
    
    // Performs a GET request to download image data.  Needs completion handler as data is a background task.
    func downloadImage(urlLink: String, completion: @escaping ((Data) -> ())) {
        if let url = URL(string: urlLink) {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                if let errorMsg = error {
                    print(errorMsg)
                    return
                }
                if let imageData = data {
                    completion(imageData)
                }
            }.resume()
        }
    }
    
}

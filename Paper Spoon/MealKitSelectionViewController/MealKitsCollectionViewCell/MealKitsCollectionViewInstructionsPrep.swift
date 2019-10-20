//
//  MealKitsCollectionViewInstructionsPrep.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 10/19/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

extension MealKitsCollectionViewCell {
    
    private func downloadInstructionImages() {
        // skip if instructions have already been downloaded
        if self.menuOption?.recipe?.instructionImages != nil { return }
        
        // counter for instruction images downloaded
        var instructionsCounter = 0
        
        self.mainThread.async {
            self.activityIndicator.activityInProgress()
        }
        
        if let instructionImageLinks = self.menuOption?.recipe?.instructionImageLinks {
            for x in 0..<instructionImageLinks.count {
                let imageLink = instructionImageLinks[x]
                
                // create a dispatch work item for each instruction image to download
                let dispatchWorkItem = DispatchWorkItem(block: {
                    ImageAPI.shared.downloadImage(urlLink: imageLink, completion: {
                        
                        print(imageLink)
                        instructionsCounter += 1
                        print(instructionsCounter)
                        
                        if let image = UIImage(data: $0) {
                            self.instructionImages[x] = image
                            
                            if instructionsCounter >= instructionImageLinks.count {
                                print("dispatch leave")
                                self.convertInstructionsIntoArray()
                                self.dispatchGroup.leave()
                            }
                        }
                    })
                })
                // add each dispatch work item to Group
                self.backgroundThread.async(group: self.dispatchGroup, execute: dispatchWorkItem)
            }
            self.dispatchGroup.enter()
        }
    }
    
    private func convertInstructionsIntoArray() {
        // convert dictionary into ORDERED array (otherwise could have used dic.values.map {$0})
        for x in 0..<instructionImages.count {
            if let image = instructionImages[x] {
                self.instructionImgArray.append(image)
                print("instructions image available")
            }
        }
        
        // pass instruction images to menuOption object
        self.menuOption?.recipe?.instructionImages = self.instructionImgArray
    }
    
    
    @objc internal func showInstructions() {
        // lock parent scroll view to prevent scrolling to other recipes
        self.scrollViewLockDelegate?.lockScrollView()
        
        // download instructions images
        self.downloadInstructionImages()
        
        // execute after all dispatch group items have run
        dispatchGroup.notify(queue: mainThread) { [weak self] in
            guard let menuOption = self?.menuOption else { return }
            
            self?.activityIndicator.activityEnded()
            
            // present instructions view
            print("show instructions")
            self?.mealKitSelectionViewControllerDelegate?.presentInstructions(menuOption: menuOption)
        }
    }
    
}

//
//  MealKitsCollectionViewCell.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/2/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class MealKitsCollectionViewCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setup()
    }
    
    var menuOption: MenuOption? {
        didSet {
            self.nameLabel.text = self.menuOption?.recipe?.name
            self.descriptionTextfield.text = self.menuOption?.recipe?.description
        }
    }
    
    // MARK:  UI Elements
    let nameLabel = UILabel()
    let getCookingBtn = UIButton()
    let descriptionTextfield = UITextView()
    let activityIndicator = ActivityIndicator()
    
    // MARK:  Delegates
    var scrollViewLockDelegate: ScrollViewLockDelegate?
    var mealKitSelectionViewControllerDelegate: MealKitSelectionViewControllerDelegate?
    
    // MARK:  Threading
    let backgroundThread = DispatchQueue.global(qos: .background)
    let mainThread = DispatchQueue.main
    let dispatchGroup = DispatchGroup()
    
    private func setup() {
        self.backgroundColor = UIColor.white
        self.addLabel()
        self.addGetCookingButton()
        self.addDescriptionTextfield()
    }
    
    private func addLabel() {
        self.nameLabel.textColor = .black
        self.addSubview(self.nameLabel)
        
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor),
            self.nameLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.nameLabel.heightAnchor.constraint(equalToConstant: 35)
        ])
    }
    
    private func addGetCookingButton() {
        self.getCookingBtn.setTitle("Get Cooking", for: .normal)
        self.getCookingBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.getCookingBtn.backgroundColor = UIColor.color8
        self.getCookingBtn.layer.cornerRadius = 5
        
        self.addSubview(self.getCookingBtn)
        self.getCookingBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.getCookingBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            self.getCookingBtn.heightAnchor.constraint(equalToConstant: 60),
            self.getCookingBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            self.getCookingBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        
        self.getCookingBtn.addTarget(self, action: #selector(self.showInstructions), for: .touchUpInside)
    }
    
    private func addDescriptionTextfield() {
        self.descriptionTextfield.textColor = .blue
        self.descriptionTextfield.textAlignment = .left
        self.addSubview(self.descriptionTextfield)
        
        self.descriptionTextfield.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.descriptionTextfield.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5),
            self.descriptionTextfield.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor),
            self.descriptionTextfield.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5),
            self.descriptionTextfield.bottomAnchor.constraint(equalTo: self.getCookingBtn.topAnchor)
        ])
    }
    
    // create temp container for instruction images
    var instructionImages = [Int: UIImage]()
    var instructionImgArray = [UIImage]()
    
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
    
    
    @objc private func showInstructions() {
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
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

protocol DismissPopUpDelegate: AnyObject {
    func dismissPopup()
}

extension MealKitsCollectionViewCell: DismissPopUpDelegate {
    func dismissPopup() {
//        self.instructionsView?.dismiss(animated: true, completion: nil)
        self.scrollViewLockDelegate?.unlockScrollView()
    }
}

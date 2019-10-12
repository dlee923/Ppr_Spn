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
    
    let nameLabel = UILabel()
    let getCookingBtn = UIButton()
    let descriptionTextfield = UITextView()
    var scrollViewLockDelegate: ScrollViewLockDelegate?
    
    let activityIndicator = ActivityIndicator()
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
    var instructionImages = [UIImage]()
    
    private func downloadInstructionImages() {
        // skip if instructions have already been downloaded
        if self.menuOption?.recipe?.instructionImages != nil { return }
        
        self.mainThread.async {
            self.activityIndicator.activityInProgress()
        }
        
        if let instructionImageLinks = self.menuOption?.recipe?.instructionImageLinks {
            for imageLink in instructionImageLinks {
                // create a dispatch work item for each instruction image to download
                let dispatchWorkItem = DispatchWorkItem(block: {
                    ImageAPI.shared.downloadImage(urlLink: imageLink, completion: {
                        if let image = UIImage(data: $0) {
                            self.instructionImages.append(image)
                        }
                        print(imageLink)
                        print("instruction image downloaded")
                        self.dispatchGroup.leave()
                    })
                })
                // add each dispatch work item to Group
                self.dispatchGroup.enter()
                self.backgroundThread.async(group: self.dispatchGroup, execute: dispatchWorkItem)
                // use wait to download in chronological order?
                self.dispatchGroup.wait()
            }
        }
    }
    
    var instructionsView: InstructionsView?
    
    @objc private func showInstructions() {
        // lock parent scroll view to prevent scrolling to other recipes
        self.scrollViewLockDelegate?.lockScrollView()
        
        // download instructions images
        self.downloadInstructionImages()
        
        // execute after all dispatch group items have run
        dispatchGroup.notify(queue: mainThread) { [weak self] in
            guard let mealKitsCollectionViewCell = self else { return }
            // pass instruction images to menuOption object
            self?.menuOption?.recipe?.instructionImages = self?.instructionImages
            mealKitsCollectionViewCell.activityIndicator.activityEnded()
            
            // present instructions view
            print("show instructions")
            mealKitsCollectionViewCell.instructionsView = InstructionsView(frame: mealKitsCollectionViewCell.frame)
            mealKitsCollectionViewCell.instructionsView?.menuOption = mealKitsCollectionViewCell.menuOption
            mealKitsCollectionViewCell.instructionsView?.dismissPopUpDelegate = self
            if let instructionsVw = mealKitsCollectionViewCell.instructionsView {
                // need to attach to center of collectionView??
                mealKitsCollectionViewCell.addSubview(instructionsVw)
            }
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
        self.instructionsView?.removeFromSuperview()
        self.scrollViewLockDelegate?.unlockScrollView()
    }
}

//
//  InstructionsView.swift
//  Paper Spoon
//
//  Created by Daniel Lee on 9/7/19.
//  Copyright © 2019 DLEE. All rights reserved.
//

import UIKit

class InstructionsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    deinit {
        print("letting go of instructions viewcontroller")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.mealKitSelectionViewControllerDelegate?.unlockScrollView()
    }
    
    // MARK: Variables
    var instructionsCollectionView: InstructionsCollectionView?
    var instructionsImgCollectionView: InstructionsImgCollectionView?
    var finishedCookingBtn = UIButton()
    weak var menuOption: MenuOption? {
        didSet {
            self.instructionsCollectionView?.menuOption = self.menuOption
            self.instructionsImgCollectionView?.menuOption = self.menuOption
        }
    }
    
    // MARK:  Delegates
    weak var mealKitSelectionViewControllerDelegate: MealKitSelectionViewControllerDelegate?
    
    private func setup() {
        self.view.backgroundColor = UIColor.themeColor1
        self.addFinishedCookingBtn()
        self.addInstructionsCollectionView()
        self.addInstructionsImgCollectionView()
    }
    
    private func addFinishedCookingBtn() {
        self.finishedCookingBtn.setTitle("Finished Cooking!", for: .normal)
        self.finishedCookingBtn.titleLabel?.font = UIFont.fontSunflower?.withSize(20)
        self.finishedCookingBtn.backgroundColor = UIColor.color2
        self.finishedCookingBtn.layer.cornerRadius = 5
        self.view.addSubview(self.finishedCookingBtn)
        
        self.finishedCookingBtn.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.finishedCookingBtn.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 5),
            self.finishedCookingBtn.heightAnchor.constraint(equalToConstant: 60),
            self.finishedCookingBtn.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            self.finishedCookingBtn.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
        self.finishedCookingBtn.addTarget(self, action: #selector(self.dismissInstructions), for: .touchUpInside)
    }
    
    @objc private func dismissInstructions() {
        self.dismiss(animated: true, completion: nil)
    }
    
    private func addInstructionsCollectionView() {
        self.instructionsCollectionView = InstructionsCollectionView(frame: self.view.frame)
        self.instructionsCollectionView?.menuOption = self.menuOption
        self.instructionsCollectionView?.instructionsViewControllerDelegate = self
        guard let instructionsCV = self.instructionsCollectionView else { return }
        self.view.addSubview(instructionsCV)
        
        instructionsCV.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            instructionsCV.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            instructionsCV.topAnchor.constraint(equalTo: self.view.topAnchor),
            instructionsCV.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            instructionsCV.bottomAnchor.constraint(equalTo: self.finishedCookingBtn.topAnchor, constant: -5)
        ])
    }
    
    private func addInstructionsImgCollectionView() {
        self.instructionsImgCollectionView = InstructionsImgCollectionView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width * 0.2, height: (self.view.frame.height * 0.35) - 10), collectionViewLayout: UICollectionViewFlowLayout())
        self.instructionsImgCollectionView?.instructionsViewControllerDelegate = self
        self.instructionsImgCollectionView?.menuOption = self.menuOption
        self.instructionsImgCollectionView?.translatesAutoresizingMaskIntoConstraints = false
        guard let instructionsImgCollectionView = self.instructionsImgCollectionView else { return }
        self.view.addSubview(instructionsImgCollectionView)
        
        NSLayoutConstraint.activate([
            instructionsImgCollectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 5),
            instructionsImgCollectionView.heightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.35 * 0.9                                                                          ),
            instructionsImgCollectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -5),
            instructionsImgCollectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.15)
        ])
    }
    
}


protocol InstructionsViewControllerDelegate: AnyObject {
    func selectInstrutionsPane(number: Int)
    func selectInstructionsMiniPane(number: Int)
}


extension InstructionsViewController: InstructionsViewControllerDelegate {
    func selectInstrutionsPane(number: Int) {
        self.instructionsCollectionView?.scrollToItem(at: IndexPath(item: number, section: 0), at: .top, animated: true)
    }
    
    func selectInstructionsMiniPane(number: Int) {
        self.instructionsImgCollectionView?.selectItem(at: IndexPath(item: number, section: 0), animated: false, scrollPosition: .top)
    }
}

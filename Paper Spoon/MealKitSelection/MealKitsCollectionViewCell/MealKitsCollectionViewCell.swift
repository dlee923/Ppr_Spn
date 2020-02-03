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
    
    // MARK:  Variables
    var menuOption: MenuOption? {
        didSet {
            self.loadRecipeData()
        }
    }
    
    // MARK:  UI Elements
    let backgroundSplash = UIView()
    let title = UILabel()
    let subtitle = UILabel()
    let rating = RatingView()
    let image = UIImageView()
    let imageShadow = UIView()
    let recipeDescription = UITextView()
    let difficulty = UILabel()
    let nutritionStack = UIStackView()
    let nutritionStackContainer = UIView()
    let protein = UILabel()
    let calories = UILabel()
    let carbs = UILabel()
    let fats = UILabel()
    let proteinLbl = UILabel()
    let fatsLbl = UILabel()
    let carbsLbl = UILabel()
    let caloriesLbl = UILabel()
    let ingredientsView = IngredientsListCollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    
    lazy var ingredientsButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.BtnSizeMultiplier, height: self.frame.width * self.BtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    
    lazy var likeButton = RecipeCellButton(frame: CGRect(x: 0, y: 0, width: self.frame.width * self.BtnSizeMultiplier, height: self.frame.width * self.BtnSizeMultiplier), color: self.splashColor ?? UIColor.blue)
    
    let getCookingBtn = UIButton()
    let getCookingBtnShadow = UIView()
    
    var splashColor: UIColor? {
        didSet {
            self.ingredientsView.splashColor = self.splashColor
        }
    }
    
    let activityIndicator = ActivityIndicator()
    
    // MARK:  Delegates
    var mealKitSelectionViewControllerDelegate: MealKitSelectionViewControllerDelegate?
    var favCollectionViewControllerDelegate: FavCollectionViewControllerDelegate?
    
    // MARK:  Temp containers for instruction images
    var instructionImages = [Int: UIImage]()
    var instructionImgArray = [UIImage]()
    
    // MARK:  Threading
    let backgroundThread = DispatchQueue.global(qos: .background)
    let mainThread = DispatchQueue.main
    let dispatchGroup = DispatchGroup()
    
    // MARK: - Layout Properties
    let imageWidthMultiplier: CGFloat = DeviceViews.imageWidthMultiplier[Device.current.deviceType] ?? 0.65
    let sideMarginMultiplier: CGFloat = 0.12
    let BtnSizeMultiplier: CGFloat = DeviceViews.BtnSizeMultiplier[Device.current.deviceType] ?? 0.13
    
    var isIngredientsVisible: Bool? {
        didSet {
            if let isIngredientsVisible = self.isIngredientsVisible {
                self.ingredientsButton.tintColor = isIngredientsVisible ? UIColor.white.withAlphaComponent(0.5) : UIColor.white
            }
        }
    }
    
    var sideMargin: CGFloat { return self.frame.width * self.sideMarginMultiplier }

    // MARK: - View Animatable Constraint Properties
    var backgroundSplashHeight: NSLayoutConstraint?
    var backgroundSplashHeightSquished: NSLayoutConstraint?
       
    var imageShadowBottom: NSLayoutConstraint?
    var imageBottom: NSLayoutConstraint?
       
    var ingredientsButtonBottom: NSLayoutConstraint?
    var ingredientsButtonBottomSquished: NSLayoutConstraint?
       
    var ingredientsViewBottom: NSLayoutConstraint?
    var ingredientsViewTop: NSLayoutConstraint?
       
    var ingredientsViewBottomSquished: NSLayoutConstraint?
    var ingredientsViewTopSquished: NSLayoutConstraint?
    
    
    private func setup() {
        self.backgroundColor = UIColor.themeColor1
        
        self.addViews()
        
        self.backgroundSplashConstraints()
        self.titleConstraints()
        self.subTitleConstraints()
        self.ImageConstraints()
        self.descriptionConstraints()
        self.ingredientsButtonConstraints()
        self.nutritionConstraints()
        self.ratingConstraints()
        self.likeConstraints()
        self.ingredientsViewConstraints()
        self.getCookingButtonConstraints()
        
        self.modifyColors()
        self.modifyTitle()
        self.modifySubtitle()
        self.modifyImage()
        self.modifyDescription()
        self.modifyIngredientsBtn()
        self.modifyNutritionStack()
        self.modifyLikeBtn()
        self.modifyRating()
        self.modifyIngredientsView()
        self.modifyGetCookingButton()
    }
    
    private func addViews() {
        self.addSubview(self.backgroundSplash)                          // Included
        self.addSubview(self.title)                                     // Included
        self.addSubview(self.subtitle)                                  // Included
        self.addSubview(self.rating)                                    // Included
        self.addSubview(self.likeButton)                                // Included
//        self.addSubview(self.difficulty)                              // NOT INCLUDED
        self.addSubview(self.nutritionStackContainer)                   // Included
        self.addSubview(self.recipeDescription)                         // Included + must overlap ingredientsView in view heirarchy
        self.addSubview(self.ingredientsView)                           // Included + must overlap nutritionStackContainer in view heirarchy
        self.nutritionStackContainer.addSubview(self.nutritionStack)    // Included
        self.addSubview(self.ingredientsButton)                         // Included
        self.addSubview(self.imageShadow)                               // Included
        self.addSubview(self.image)                                     // Included
        self.addSubview(self.getCookingBtnShadow)                       // Included
        self.addSubview(self.getCookingBtn)                             // Included
    }
        
    // Method to load and reload data based on changes to Recipe Obj.
    internal func loadRecipeData() {
        self.title.text = self.menuOption?.recipeName
        self.subtitle.text = self.menuOption?.recipeSubtitle
        if let imageData = self.menuOption?.recipe?.recipeImage {
            self.image.image = imageData
        }
        self.recipeDescription.text = "\(self.menuOption?.recipe?.description ?? "no description")\n\n\n"
        self.protein.text = "\(self.menuOption?.recipe?.nutrition?.proteinContent?.amount ?? 0)\(self.menuOption?.recipe?.nutrition?.proteinContent?.measurementType ?? "")"
        self.fats.text = "\(self.menuOption?.recipe?.nutrition?.fatContent?.amount ?? 0)\(self.menuOption?.recipe?.nutrition?.fatContent?.measurementType ?? "")"
        self.carbs.text = "\(self.menuOption?.recipe?.nutrition?.carbohydrateContent?.amount ?? 0)\(self.menuOption?.recipe?.nutrition?.carbohydrateContent?.measurementType ?? "")"
        self.calories.text = "\(self.menuOption?.recipe?.nutrition?.calories?.amount ?? 0)\(self.menuOption?.recipe?.nutrition?.calories?.measurementType ?? "")"
        
        if let isLiked = self.menuOption?.isLiked {
            self.likeButton.tintColor = isLiked ? UIColor.color2 : self.splashColor ?? UIColor.blue
        }
        if let userRating = self.menuOption?.userRating {
            self.rating.highlightStars(rating: userRating)
        }
        self.ingredientsView.ingredients = self.menuOption?.recipe?.ingredients
    }
    
    // reset reusable cell's default color and other non content properties
    override func prepareForReuse() {
        self.likeButton.tintColor = self.splashColor ?? UIColor.blue
        self.backgroundSplashHeightSquished?.isActive = false
        self.backgroundSplashHeight?.isActive = true
        self.imageShadow.transform = CGAffineTransform.identity
        self.image.transform = CGAffineTransform.identity
        self.likeButton.transform = CGAffineTransform.identity
        self.rating.prepareForReuse()
        self.ingredientsButtonBottomSquished?.isActive = false
        self.ingredientsButtonBottom?.isActive = true
        self.ingredientsButton.tintColor = .white
        self.nutritionStackContainer.alpha = 1.0
        self.ingredientsViewTopSquished?.isActive = false
        self.ingredientsViewBottomSquished?.isActive = false
        self.ingredientsViewTop?.isActive = true
        self.ingredientsViewBottom?.isActive = true
        super.prepareForReuse()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

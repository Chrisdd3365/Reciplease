//
//  DetailedFavoriteRecipeView.swift
//  Reciplease
//
//  Created by Christophe DURAND on 26/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class DetailedFavoriteRecipeView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var backgroundDetailedFavoriteRecipeImageView: UIImageView!
    @IBOutlet weak var detailedFavoriteRecipeNameLabel: UILabel!
    @IBOutlet weak var detailedFavoriteRecipeRatingLabel: UILabel!
    @IBOutlet weak var detailedFavoriteRecipeTimerLabel: UILabel!
    @IBOutlet weak var detailedFavoriteRecipeDescription: UITextView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var littleBlackView: UIView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Property
    var detailedFavoriteRecipesViewModel: DetailedFavoriteRecipesViewModel! {
        didSet {
            detailedFavoriteRecipeNameLabel.text = detailedFavoriteRecipesViewModel.name
            detailedFavoriteRecipeDescription.text = detailedFavoriteRecipesViewModel.recipeDetails
            detailedFavoriteRecipeRatingLabel.text = detailedFavoriteRecipesViewModel.rating
            detailedFavoriteRecipeTimerLabel.text = detailedFavoriteRecipesViewModel.timer 
            backgroundDetailedFavoriteRecipeImageView.load(imageURL: detailedFavoriteRecipesViewModel.backgroundImageURL)
            backgroundDetailedFavoriteRecipeImageView.sd_setImage(with: URL(string: detailedFavoriteRecipesViewModel.backgroundImageURL ?? ""))
        }
    }
    
    //MARK: - Methods
    //Method to setup the activity indicator
    func toggleActivityIndicator(shown: Bool) {
        if shown == false {
            activityIndicator.isHidden = !shown
            activityIndicator.stopAnimating()
            getDirectionsButton.isHidden = shown
        } else {
            activityIndicator.isHidden = !shown
            activityIndicator.startAnimating()
            getDirectionsButton.isHidden = shown
        }
    }
}

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
    //Method to configure the UI of the detailedFavoriteRecipeView
    func detailedFavoriteRecipeConfigure(detailedFavoriteRecipeName: String, detailedFavoriteRecipeDetails: String, rating: Int, timer: Int, backgroundDetailedFavoriteRecipeImageURL: String) {
        detailedFavoriteRecipeNameLabel.text = detailedFavoriteRecipeName
        detailedFavoriteRecipeDescription.text = detailedFavoriteRecipeDetails
        detailedFavoriteRecipeRatingLabel.text = String(rating)
        detailedFavoriteRecipeTimerLabel.text = String(timer) + " min"
        backgroundDetailedFavoriteRecipeImageView.load(imageURL: backgroundDetailedFavoriteRecipeImageURL)
        littleBlackView.layer.borderWidth = 1
        littleBlackView.layer.borderColor = UIColor.init(red: 222/255, green: 225/255, blue: 227/255, alpha: 1).cgColor
    }
}

//
//  DetailedRecipeView.swift
//  Reciplease
//
//  Created by Christophe DURAND on 19/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class DetailedRecipeView: UIView {
    //MARK: - Outlets
    @IBOutlet weak var detailedRecipeBackgroundImageView: UIImageView!
    @IBOutlet weak var detailedRecipeNameLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var detailedRecipeDescriptionTextView: UITextView!
    @IBOutlet weak var getDirectionsButton: UIButton!
    @IBOutlet weak var littleBlackView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favoriteButton: UIButton!
    
    //MARK: - Property
    var detailedRecipesViewModel: DetailedRecipesViewModel! {
        didSet {
            detailedRecipeNameLabel.text = detailedRecipesViewModel.name
            detailedRecipeDescriptionTextView.text = detailedRecipesViewModel.recipeDetails
            ratingLabel.text = detailedRecipesViewModel.rating
            timerLabel.text = detailedRecipesViewModel.timer + " min"
            detailedRecipeBackgroundImageView.load(imageURL: detailedRecipesViewModel.backgroundImageURL)
            detailedRecipeBackgroundImageView.sd_setImage(with: URL(string: detailedRecipesViewModel.backgroundImageURL))
        }
    }
    
    //MARK: - Method
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

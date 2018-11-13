//
//  FavoriteRecipeTableViewCell.swift
//  Reciplease
//
//  Created by Christophe DURAND on 26/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoriteRecipeTableViewCell: UITableViewCell {
    
    //MARK: - Outlets
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var favoriteRecipeNameLabel: UILabel!
    @IBOutlet weak var favoriteRecipeDetailsLabel: UILabel!
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var favoriteRecipeRatingLabel: UILabel!
    @IBOutlet weak var favoriteRecipeTimerLabel: UILabel!
    
    //MARK: - Methods
    //Method to configure the favorite recipe cell UI
    func favoriteRecipeCellConfigure(favoriteRecipeName: String, favoriteRecipeDetails: String, ratings: Int, timer: Int, backgroundRecipeImageURL: String) {
        favoriteRecipeNameLabel.text = favoriteRecipeName
        favoriteRecipeDetailsLabel.text = favoriteRecipeDetails
        favoriteRecipeRatingLabel.text = String(ratings)
        favoriteRecipeTimerLabel.text = String(timer) + " min"
        backgroundImageView.load(imageURL: backgroundRecipeImageURL)
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(red: 222/255, green: 225/255, blue: 227/255, alpha: 1).cgColor
    }
}

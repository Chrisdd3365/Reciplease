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
    
    //MARK: - Property
    var favoritesRecipesViewModel: FavoritesRecipesViewModel! {
        didSet {
            favoriteRecipeNameLabel.text = favoritesRecipesViewModel.name
            favoriteRecipeDetailsLabel.text = favoritesRecipesViewModel.ingredients
            favoriteRecipeRatingLabel.text = favoritesRecipesViewModel.rating
            favoriteRecipeTimerLabel.text = favoritesRecipesViewModel.timer 
            backgroundImageView.load(imageURL: favoritesRecipesViewModel.backgroundImageURL)
            backgroundImageView.sd_setImage(with: URL(string: favoritesRecipesViewModel.backgroundImageURL ?? ""))
        }
    }
    
    //MARK: - Method

}

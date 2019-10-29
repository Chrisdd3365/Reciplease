//
//  RecipeTableViewCell.swift
//  Reciplease
//
//  Created by Christophe DURAND on 12/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit
import SDWebImage

class RecipeTableViewCell: UITableViewCell {
    //MARK: - Outlets
    @IBOutlet weak var recipeBackgroundImage: UIImageView!
    @IBOutlet weak var recipeTitleLabel: UILabel!
    @IBOutlet weak var recipeDetailsLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    //MARK: - Property
    //Setup Cell
    var matchingRecipesViewModel: MatchingRecipesViewModel! {
        didSet {
            recipeTitleLabel.text = matchingRecipesViewModel.name
            recipeDetailsLabel.text = matchingRecipesViewModel.recipeDetails
            ratingsLabel.text = matchingRecipesViewModel.rating
            timerLabel.text = matchingRecipesViewModel.timer + " min"
            recipeBackgroundImage.load(imageURL: matchingRecipesViewModel.backgroundImageURL)
            recipeBackgroundImage.sd_setImage(with: URL(string: matchingRecipesViewModel.backgroundImageURL))
        }
    }
    
    //MARK: - Method

}

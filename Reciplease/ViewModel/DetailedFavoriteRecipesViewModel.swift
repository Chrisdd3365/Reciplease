//
//  DetailedFavoriteRecipesViewModel.swift
//  Reciplease
//
//  Created by Christophe DURAND on 24/09/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class DetailedFavoriteRecipesViewModel {
    //MARK: - Properties
    let name: String?
    let recipeDetails: String?
    var ingredients = ""
    let rating: String?
    let timer: String?
    let backgroundImageURL: String?
    let sourceUrl: String?
    
    //Dependency Injection (DI)
    init(favoriteRecipe: FavoriteRecipe) {
        self.name = favoriteRecipe.recipeName
        self.recipeDetails = ingredients.convertDetailedFavoriteRecipeIngredients(detailedFavoriteRecipeIngredients: favoriteRecipe.detailedIngredients ?? "")
        self.rating = String(describing: favoriteRecipe.rating)
        self.timer = String(describing: favoriteRecipe.timer) + " min"
        self.backgroundImageURL = favoriteRecipe.image
        self.sourceUrl = favoriteRecipe.sourceUrl
    }
    
    //MARK: - Methods
    
}

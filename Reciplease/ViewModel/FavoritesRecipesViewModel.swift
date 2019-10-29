//
//  FavoritesRecipesViewModel.swift
//  Reciplease
//
//  Created by Christophe DURAND on 19/09/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class FavoritesRecipesViewModel {
    //MARK: - Properties
    let name: String?
    let recipeDetails: String?
    let ingredients: String?
    let rating: String?
    let timer: String?
    let backgroundImageURL: String?
    let sourceUrl: String?
    
    //Dependency Injection (DI)
    init(favoriteRecipe: FavoriteRecipe) {
        self.name = favoriteRecipe.recipeName
        self.recipeDetails = favoriteRecipe.detailedIngredients
        self.ingredients = favoriteRecipe.ingredients
        self.rating = String(describing: favoriteRecipe.rating)
        self.timer = String(describing: favoriteRecipe.timer) + " min"
        self.backgroundImageURL = favoriteRecipe.image
        self.sourceUrl = favoriteRecipe.sourceUrl
    }

    //MARK: - Method
    
}

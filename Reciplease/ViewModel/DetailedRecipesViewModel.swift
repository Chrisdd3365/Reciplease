//
//  DetailedRecipesViewModel.swift
//  Reciplease
//
//  Created by Christophe DURAND on 17/09/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class DetailedRecipesViewModel {
    //MARK: - Properties
    let name: String
    var recipeDetails: String
    var ingredients = ""
    let rating: String
    let timer: String
    let backgroundImageURL: String
    let sourceRecipeUrl: String
    
    //Dependency Injection (DI)
    init(detailedRecipe: DetailedRecipe) {
        self.name = detailedRecipe.name
        self.recipeDetails  = ingredients.convertIntoStringDetailedRecipe(detailedRecipe: detailedRecipe.ingredientLines)
        self.rating = String(describing: detailedRecipe.rating)
        self.timer = String(describing: detailedRecipe.totalTimeInSeconds / 60) 
        self.backgroundImageURL = detailedRecipe.images[0].hostedLargeUrl
        self.sourceRecipeUrl = detailedRecipe.source.sourceRecipeUrl
    }
    
    //MARK: - Methods

}

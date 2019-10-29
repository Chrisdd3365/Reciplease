//
//  MatchingRecipesViewModel.swift
//  Reciplease
//
//  Created by Christophe DURAND on 17/09/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

class MatchingRecipesViewModel {
    //MARK: - Properties
    let name: String
    var recipeDetails: String
    var ingredients = ""
    let rating: String
    let timer: String
    let backgroundImageURL: String
    let id: String
    
    //Dependency Injection (DI)
    init(matchingRecipes: Matches) {
        self.name = matchingRecipes.recipeName
        self.recipeDetails = ingredients.convertIngredientsArrayIntoString(ingredients: matchingRecipes.ingredients)
        self.rating = String(describing: matchingRecipes.rating)
        self.timer = String(describing: matchingRecipes.totalTimeInSeconds / 60) 
        self.backgroundImageURL = matchingRecipes.imageUrlsBySize.image
        self.id = matchingRecipes.id
    }
    
    //MARK: - Methods

}


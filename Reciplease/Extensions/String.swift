//
//  String.swift
//  Reciplease
//
//  Created by Christophe DURAND on 18/09/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation

extension String {
    //Method to convert an array of Strings into a String
    func convertIngredientsArrayIntoString(ingredients: [String]) -> String {
        let ingredientsArray = ingredients.map{ String($0) }
        return ingredientsArray.joined(separator: ", ")
    }
    
    //Method to convert an array of Strings into String
    func convertIntoStringDetailedRecipe(detailedRecipe: [String]) -> String {
        var descriptions = ""
        for recipeDescription in detailedRecipe {
            descriptions += "- " + recipeDescription + "\n"
        }
        return descriptions
    }
    
    //Method to convert a string into a list of strings
    func convertDetailedFavoriteRecipeIngredients(detailedFavoriteRecipeIngredients: String) -> String {
        var description = ""
        let detailedFavoriteRecipeIngredientsArray = detailedFavoriteRecipeIngredients.components(separatedBy: ", ")
        for ingredients in detailedFavoriteRecipeIngredientsArray {
            description += ingredients + "\n"
        }
        return description
    }
}

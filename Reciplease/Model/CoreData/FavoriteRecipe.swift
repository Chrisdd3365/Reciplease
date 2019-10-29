//
//  FavoriteRecipe.swift
//  Reciplease
//
//  Created by Christophe DURAND on 06/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

public class FavoriteRecipe: NSManagedObject {
    //MARK : - Property
    static var all: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoritesRecipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favoritesRecipes
    }
}

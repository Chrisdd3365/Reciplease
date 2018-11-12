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
    static var all: [FavoriteRecipe] {
        let request: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        guard let favoritesRecipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return favoritesRecipes
    }
    
    func deleteRecipeFromFavorite(id: String, context: NSManagedObjectContext = AppDelegate.viewContext) {
        let fetchRequest: NSFetchRequest<FavoriteRecipe> = FavoriteRecipe.fetchRequest()
        fetchRequest.predicate = NSPredicate.init(format: "id == %@", id)
        
        do {
            let favoritesRecipes = try context.fetch(fetchRequest)
            for favoriteRecipe in favoritesRecipes {
                context.delete(favoriteRecipe)
            }
            try context.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: FavoriteRecipe.fetchRequest())
        let _ = try? viewContext.execute(deleteRequest)
    }
}

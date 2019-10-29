//
//  CoreDataManager.swift
//  Reciplease
//
//  Created by Christophe DURAND on 19/09/2019.
//  Copyright © 2019 Christophe DURAND. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    //MARK: - Methods
    //Static method to delete a recipe from the favorite list based on the attribute called "id"
    static func deleteRecipeFromFavorite(id: String, context: NSManagedObjectContext = AppDelegate.viewContext) {
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
    
    //Static method to delete everything
    static func deleteAll(viewContext: NSManagedObjectContext = AppDelegate.viewContext) {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: FavoriteRecipe.fetchRequest())
        let _ = try? viewContext.execute(deleteRequest)
    }
    
    //Method to save context
    static func saveContext() {
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
}

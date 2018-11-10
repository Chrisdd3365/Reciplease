//
//  CoreDataTests.swift
//  RecipleaseTests
//
//  Created by Christophe DURAND on 10/11/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import XCTest
import CoreData
@testable import Reciplease

class CoreDataTests: XCTestCase {
    
    //MARK: - Vars
    var container: NSPersistentContainer!
    
    override func setUp() {
        container = AppDelegate.persistentContainer
    }
    
    //MARK: - Methods
    private func insertFavoriteRecipeItem(into managedObjectContext: NSManagedObjectContext) {
        let newFavoriteRecipeItem = FavoriteRecipe(context: managedObjectContext)
        newFavoriteRecipeItem.recipeName = "Lemon Meltaways"
    }
    
    //MARK: - Unit Tests
    func testInsertManyFavoriteRecipeItemsInPersistentContainer() {
        for _ in 0 ..< 100000 {
            insertFavoriteRecipeItem(into: container.newBackgroundContext())
        }
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }
    
//    func testDeleteFavoriteRecipeItemInPersistentContainer(from managedObjectContext: NSManagedObjectContext) {
//        let favoritesRecipes = FavoriteRecipe.all
//        let favoriteRecipe = favoritesRecipes[0]
//        let numberOfFavoritesRecipes = favoritesRecipes.count
//        favoriteRecipe.deleteRecipeFromFavorite(index: favoriteRecipe)
//        XCTAssertEqual(numberOfFavoritesRecipes, numberOfFavoritesRecipes-1)
//    }
}

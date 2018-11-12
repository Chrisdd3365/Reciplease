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
    
    //MARK: - Properties
    var container: NSPersistentContainer!
    var favoriteRecipe: FavoriteRecipe!
    
    //MARK: - Tests Life Cycle
    override func setUp() {
        container = AppDelegate.persistentContainer
    }
    
    override func tearDown() {
        FavoriteRecipe.deleteAll()
        container = nil
        super.tearDown()
    }
    
    //MARK: - Methods
    private func insertFavoriteRecipeItem(into managedObjectContext: NSManagedObjectContext) {
        let newFavoriteRecipeItem = FavoriteRecipe(context: managedObjectContext)
        newFavoriteRecipeItem.id = "Lemon-Meltaways-1985782"
    }
    
    //MARK: - Unit Tests
    func testInsertManyFavoriteRecipeItemsInPersistentContainer() {
        for _ in 0 ..< 100000 {
            insertFavoriteRecipeItem(into: container.newBackgroundContext())
        }
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }
    
    func testDeleteFavoriteRecipeItemInPersistentContainer() {
        let newFavoriteRecipeItem = FavoriteRecipe(context: container.newBackgroundContext())
        newFavoriteRecipeItem.id = "Lemon-Meltaways-1985782"
        favoriteRecipe.deleteRecipeFromFavorite(id: newFavoriteRecipeItem.id!, context: container.newBackgroundContext())
        XCTAssertEqual(FavoriteRecipe.all.count, FavoriteRecipe.all.count - 1)
    }
    
    func testDeleteAllFavoriteRecipeItemsInPersistentContainer() {
        FavoriteRecipe.deleteAll(viewContext: container.newBackgroundContext())
        XCTAssertEqual(FavoriteRecipe.all, [])
    }
}

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
    
    //MARK: - Tests Life Cycle
    override func setUp() {
        initStubs()
        container = AppDelegate.persistentContainer
    }
    
    override func tearDown() {
        flushData()
        FavoriteRecipe.deleteAll()
        container = nil
        super.tearDown()
    }
    
    //MARK: - Methods
    private func insertFavoriteRecipeItem(into managedObjectContext: NSManagedObjectContext) {
        let newFavoriteRecipeItem = FavoriteRecipe(context: managedObjectContext)
        newFavoriteRecipeItem.id = "test"
    }
    
    //MARK: - Unit Tests
    func testInsertManyFavoriteRecipeItemsInPersistentContainer() {
        for _ in 0 ..< 10 {
            insertFavoriteRecipeItem(into: container.newBackgroundContext())
        }
        XCTAssertNoThrow(try container.newBackgroundContext().save())
    }
    
    func testDeleteFavoriteRecipeItemInPersistentContainer() {

        let favoritesRecipes = FavoriteRecipe.all
        let favoriteRecipe = favoritesRecipes[0]
        
        FavoriteRecipe.deleteRecipeFromFavorite(id: favoriteRecipe.id!)
        
        XCTAssert(true)
    }
 
    func testDeleteAllFavoriteRecipeItemsInPersistentContainer() {
        FavoriteRecipe.deleteAll(viewContext: container.newBackgroundContext())
        XCTAssertEqual(FavoriteRecipe.all, [])
    }
}

extension CoreDataTests {
    
    func initStubs() {
        func insertFavoriteRecipeItemIntoList(id: String) -> FavoriteRecipe? {
            let favoriteRecipe = NSEntityDescription.insertNewObject(forEntityName: "FavoriteRecipe", into: AppDelegate.viewContext)
           favoriteRecipe.setValue("test", forKey: "id")
            return favoriteRecipe as? FavoriteRecipe
        }
        
        _ = insertFavoriteRecipeItemIntoList(id: "test1")
        _ = insertFavoriteRecipeItemIntoList(id: "test2")
        _ = insertFavoriteRecipeItemIntoList(id: "test3")
        _ = insertFavoriteRecipeItemIntoList(id: "test4")
        _ = insertFavoriteRecipeItemIntoList(id: "test5")
        
        do {
            try AppDelegate.viewContext.save()
        }  catch {
            print("create fakes error \(error)")
        }
    }
    
    func flushData() {
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest<NSFetchRequestResult>(entityName: "FavoriteRecipe")
        let favoritesRecipes = try! AppDelegate.viewContext.fetch(fetchRequest)
        for case let favoriteRecipe as NSManagedObject in favoritesRecipes {
            AppDelegate.viewContext.delete(favoriteRecipe)
        }
        try! AppDelegate.viewContext.save()
    }
}

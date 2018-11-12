//
//  DetailedRecipesViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 19/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class DetailedRecipesViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var detailedRecipeView: DetailedRecipeView!
    
    //MARK: - Properties
    var detailedRecipe: DetailedRecipe!
    var matchingRecipe: Matches!
    var favoriteRecipe = FavoriteRecipe.all
 
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItemTitle()
        setDetailedRecipeUI()
        detailedRecipeView.toggleActivityIndicator(shown: false)
        detailedRecipeView.favoriteButton.setImage(updateFavoriteButtonImage(), for: .normal)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        favoriteRecipe = FavoriteRecipe.all
        detailedRecipeView.favoriteButton.setImage(updateFavoriteButtonImage(), for: .normal)
    }
    
    //MARK: - Actions
    @IBAction func favoriteFunctionality(_ sender: UIButton) {
        addToFavoriteSetup()
    }
    
    @IBAction func getDirections(_ sender: Any) {
        getDirectionsFromSourceRecipeURL()
    }
    
    @IBAction func share(_ sender: UIButton) {
        sharingRecipeButtonTapped()
    }
    
    //MARK: - Methods
    private func setNavigationItemTitle() {
        navigationItem.title = "Detailed Recipe"
    }
    
    private func addToFavoriteSetup() {
        guard let tabItems = tabBarController?.tabBar.items else { return }
        let tabItem = tabItems[1]
        
        if checkFavoriteRecipeList() == false {
            detailedRecipeView.favoriteButton.setImage(UIImage(named: "favorite"), for: .normal)
            saveFavoriteRecipe()
            tabItem.badgeValue = "New"
            favoriteRecipe = FavoriteRecipe.all
        } else {
            favoriteRecipe = FavoriteRecipe.all
            showAlert(title: "Error", message: "You already add this recipe in your favorite list!")
            tabItem.badgeValue = nil
        }
    }
    
    private func checkFavoriteRecipeList() -> Bool {
        var isFavorite = false
        guard favoriteRecipe.count != 0 else { return false }
        for recipe in favoriteRecipe {
            if matchingRecipe.id == recipe.id {
                isFavorite = true
                break
            }
        }
        return isFavorite
    }
    
    private func updateFavoriteButtonImage() -> UIImage {
        let image: UIImage!
        if checkFavoriteRecipeList() {
            image = UIImage(named: "favorite")
        } else {
            image = UIImage(named: "noFavorite")
        }
        return image
    }
    
    private func sharingRecipeButtonTapped() {
        let activityController = UIActivityViewController(activityItems: ["Can you cook that for me?", detailedRecipe.source.sourceRecipeUrl], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    private func getDirectionsFromSourceRecipeURL() {
        if let detailedRecipe = detailedRecipe {
            guard let url = URL(string: detailedRecipe.source.sourceRecipeUrl) else { return }
            UIApplication.shared.open(url)
        } else {
            showAlert(title: "Error", message: "Failed to get you any directions. Try again!")
        }
    }
    
    private func setDetailedRecipeUI() {
        detailedRecipeView.detailedRecipeConfigure(detailedRecipeName: detailedRecipe.name, detailedRecipeDetails: detailedRecipe.ingredientLines, rating: detailedRecipe.rating, timer: detailedRecipe.totalTimeInSeconds / 60, backgroundDetailedRecipeImageURL: detailedRecipe.images[0].hostedLargeUrl)
    }
    
    private func saveFavoriteRecipe() {
        let favoritesRecipes = FavoriteRecipe(context: AppDelegate.viewContext)
        favoritesRecipes.id = matchingRecipe.id
        favoritesRecipes.image = detailedRecipe.images[0].hostedLargeUrl
        favoritesRecipes.recipeName = detailedRecipe.name
        favoritesRecipes.ingredients = convertIngredientsArrayIntoString(ingredients: matchingRecipe.ingredients)
        favoritesRecipes.detailedIngredients = convertIngredientsArrayIntoString(ingredients: detailedRecipe.ingredientLines)
        favoritesRecipes.rating = Int16(detailedRecipe.rating)
        favoritesRecipes.totalTimeInSeconds = Int16(detailedRecipe.totalTimeInSeconds)
        favoritesRecipes.sourceUrl = detailedRecipe.source.sourceRecipeUrl
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func convertIngredientsArrayIntoString(ingredients: [String]) -> String {
        let ingredientsArray = ingredients.map{ String($0) }
        return ingredientsArray.joined(separator: ", ")
    }
}








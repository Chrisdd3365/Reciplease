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
    var detailedFavoriteRecipe: FavoriteRecipe!
    var noFavoriteButtonImage = UIImage(named: "noFavorite")
    var favoriteButtonImage = UIImage(named: "favorite")
    var isFavorite = false
    var index: Int!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItemTitle()
        setDetailedRecipeUI()
        detailedRecipeView.toggleActivityIndicator(shown: false)
    }
    
    //MARK: - Actions
    @IBAction func favoriteFunctionality(_ sender: UIButton) {
        isFavorite = !isFavorite
        if isFavorite {
            detailedRecipeView.favoriteButton.setImage(favoriteButtonImage, for: .normal)
            setTabBarControllerItemBadgeValue(string: "New")
            saveFavoriteRecipe()
        } else {
            setTabBarControllerItemBadgeValue(string: "")
            detailedRecipeView.favoriteButton.setImage(noFavoriteButtonImage, for: .normal)
            setTabBarControllerItemBadgeValue(string: "")
            //removeFavoriteRecipe(index:)
        }
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
    
    private func setTabBarControllerItemBadgeValue(string: String) {
        guard let tabItems = tabBarController?.tabBar.items else { return }
        let tabItem = tabItems[1]
        tabItem.badgeValue = string
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
        // we add the recipe name to the dictionary with a true value
        favoritesRecipes.recipeNameInFavorite[detailedRecipe.name] = true
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

    private func removeFavoriteRecipe() {
        //TODO
        detailedFavoriteRecipe.deleteRecipeFromFavorite(index: index)
    }
    
    private func convertIngredientsArrayIntoString(ingredients: [String]) -> String {
        let ingredientsArray = ingredients.map{ String($0) }
        return ingredientsArray.joined(separator: ", ")
    }
}








//
//  DetailedRecipeViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 19/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class DetailedRecipeViewController: UIViewController {
    //MARK: - Outlet
    @IBOutlet weak var detailedRecipeView: DetailedRecipeView!
    
    //MARK: - Properties
    var detailedRecipeViewModel: DetailedRecipesViewModel?
    var matchingRecipeViewModel: MatchingRecipesViewModel?
    var favoriteRecipe = FavoriteRecipe.all
 
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setNavigationItemTitle()
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
    //Method to display the navigation item's title
    private func setNavigationItemTitle() {
        navigationItem.title = "Detailed Recipe"
    }
    
    //Method to handle the setup to add the selected recipe into the favorite recipe list
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
    
    //Method to check if the id of the selected recipe is already added into the favorite recipe list
    private func checkFavoriteRecipeList() -> Bool {
        var isFavorite = false
        guard favoriteRecipe.count != 0 else { return false }
        for recipe in favoriteRecipe {
            if matchingRecipeViewModel?.id == recipe.id {
                isFavorite = true
                break
            }
        }
        return isFavorite
    }
    
    //Method to update the favorite button image
    private func updateFavoriteButtonImage() -> UIImage {
        let image: UIImage!
        if checkFavoriteRecipeList() {
            image = UIImage(named: "favorite")
        } else {
            image = UIImage(named: "noFavorite")
        }
        return image
    }
    
    //Method to handle the sharing functionnality by tapping the share button
    private func sharingRecipeButtonTapped() {
        let activityController = UIActivityViewController(activityItems: ["Can you cook that for me?", detailedRecipeViewModel?.sourceRecipeUrl ?? ""], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    //Method to get directions from the source recipe URL by tapping the getDirections button
    private func getDirectionsFromSourceRecipeURL() {
        if let detailedRecipeViewModel = detailedRecipeViewModel {
            guard let url = URL(string: detailedRecipeViewModel.sourceRecipeUrl) else { return }
            UIApplication.shared.open(url)
        } else {
            showAlert(title: "Error", message: "Failed to get you any directions. Try again!")
        }
    }
    
    //Method to setup UI
    private func setupUI() {
        detailedRecipeView.detailedRecipesViewModel = detailedRecipeViewModel
        detailedRecipeView.viewConfigure(view: detailedRecipeView.littleBlackView)
    }
    
    //Method to save the selected recipe into the entity called FavoriteRecipe from CoreData
    private func saveFavoriteRecipe() {
        let favoriteRecipe = FavoriteRecipe(context: AppDelegate.viewContext)
        favoriteRecipe.id = matchingRecipeViewModel?.id
        favoriteRecipe.image = detailedRecipeViewModel?.backgroundImageURL
        favoriteRecipe.recipeName = detailedRecipeViewModel?.name
        favoriteRecipe.ingredients = matchingRecipeViewModel?.recipeDetails
        favoriteRecipe.detailedIngredients = detailedRecipeViewModel?.recipeDetails
        favoriteRecipe.rating = Int16(detailedRecipeViewModel?.rating ?? "") ?? 0
        favoriteRecipe.timer = Int16(detailedRecipeViewModel?.timer ?? "") ?? 0
        favoriteRecipe.sourceUrl = detailedRecipeViewModel?.sourceRecipeUrl
        
        CoreDataManager.saveContext()
    }
}








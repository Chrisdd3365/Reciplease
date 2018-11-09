//
//  DetailedFavoriteRecipeViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 26/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class DetailedFavoriteRecipeViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet var detailedFavoriteRecipeView: DetailedFavoriteRecipeView!
    
    //MARK: - Properties
    var detailedFavoriteRecipe: FavoriteRecipe!
    var isFavorite = false
    var index : Int!
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        detailedFavoriteRecipeView.toggleActivityIndicator(shown: false)
        setupNavigationBarItem()
        setDetailedFavoriteRecipeUI()
    }
    
    //MARK: - Actions
    @IBAction func getDirectionsButtonTapped(_ sender: Any) {
        getDirectionsFromSourceRecipeURL()
    }
    
    @IBAction func favoriteFunctionality(_ sender: UIButton) {
        //TODO
        detailedFavoriteRecipe.deleteRecipeFromFavorite(index: index)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share(_ sender: UIButton) {
        sharingRecipeButtonTapped()
    }
    
    //MARK: - Methods
    private func setupNavigationBarItem() {
        navigationItem.title = "Detailed Favorite Recipe"
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    private func sharingRecipeButtonTapped() {
        let activityController = UIActivityViewController(activityItems: ["Can you cook that for me?", detailedFavoriteRecipe.sourceUrl as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    private func getDirectionsFromSourceRecipeURL() {
        if let detailedFavoriteRecipe = detailedFavoriteRecipe {
            guard let url = URL(string: detailedFavoriteRecipe.sourceUrl!) else { return }
            UIApplication.shared.open(url)
        } else {
            showAlert(title: "Error", message: "Failed to get you any directions. Try again!")
        }
    }
    
    private func setDetailedFavoriteRecipeUI() {
        detailedFavoriteRecipeView.detailedFavoriteRecipeConfigure(detailedFavoriteRecipeName: detailedFavoriteRecipe.recipeName!, detailedFavoriteRecipeDetails: self.convertDetailedFavoriteRecipeIngredients(detailedFavoriteRecipeIngredients: detailedFavoriteRecipe.detailedIngredients!), rating: Int(detailedFavoriteRecipe.rating), timer: Int(detailedFavoriteRecipe.totalTimeInSeconds / 60), backgroundDetailedFavoriteRecipeImageURL: detailedFavoriteRecipe.image!)
    }
    
    private func convertDetailedFavoriteRecipeIngredients(detailedFavoriteRecipeIngredients: String) -> String {
        var description = ""
        let detailedFavoriteRecipeIngredientsArray = detailedFavoriteRecipeIngredients.components(separatedBy: ", ")
        for ingredients in detailedFavoriteRecipeIngredientsArray {
            description += "- " + ingredients + "\n"
        }
        return description
    }
}

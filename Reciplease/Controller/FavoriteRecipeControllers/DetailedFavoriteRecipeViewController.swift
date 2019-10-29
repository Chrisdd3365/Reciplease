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
    
    //MARK: - Property
    var detailedFavoriteRecipe: FavoriteRecipe!
    
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
        CoreDataManager.deleteRecipeFromFavorite(id: detailedFavoriteRecipe.id!)
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func share(_ sender: UIButton) {
        sharingRecipeButtonTapped()
    }
    
    //MARK: - Methods
    //Method to display the navigation item's title and to setup the tint color of the navigation bar of the navigation controller
    private func setupNavigationBarItem() {
        navigationItem.title = "Detailed Favorite Recipe"
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    //Method to handle the sharing functionnality when tapping on the share button
    private func sharingRecipeButtonTapped() {
        let activityController = UIActivityViewController(activityItems: ["Can you cook that for me?", detailedFavoriteRecipe.sourceUrl as Any], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
    }
    
    //Method to get directions from the source recipe URL when tapping on the getDirections button
    private func getDirectionsFromSourceRecipeURL() {
        if let detailedFavoriteRecipe = detailedFavoriteRecipe {
            guard let url = URL(string: detailedFavoriteRecipe.sourceUrl!) else { return }
            UIApplication.shared.open(url)
        } else {
            showAlert(title: "Error", message: "Failed to get you any directions. Try again!")
        }
    }
    
    //Method to setup the detailed favorite recipe UI
    private func setDetailedFavoriteRecipeUI() {
        let detailedFavoriteRecipesViewModel = DetailedFavoriteRecipesViewModel(favoriteRecipe: detailedFavoriteRecipe)
        detailedFavoriteRecipeView.detailedFavoriteRecipesViewModel = detailedFavoriteRecipesViewModel
        detailedFavoriteRecipeView.viewConfigure(view: detailedFavoriteRecipeView.littleBlackView)
    }
}

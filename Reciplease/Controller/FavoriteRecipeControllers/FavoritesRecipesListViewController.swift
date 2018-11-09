//
//  FavoritesRecipesListViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 23/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class FavoritesRecipesListViewController: UIViewController {
    
    //MARK: - Outlet
    @IBOutlet weak var favoritesRecipesListTableView: UITableView!
    
    //MARK: - Property
    var favoritesRecipes = FavoriteRecipe.all
    var index = 0
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarTitle()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setTabBarControllerItemBadgeValue()
        favoritesRecipes = FavoriteRecipe.all
        favoritesRecipesListTableView.reloadData()
    }
    
    //MARK: - Methods
    private func setNavigationBarTitle() {
        self.navigationItem.title = "List of Favorites Recipes"
    }
    
    private func setTabBarControllerItemBadgeValue() {
        guard let tabItems = tabBarController?.tabBar.items else { return }
        let tabItem = tabItems[1]
        tabItem.badgeValue = nil
    }
    
    private func saveContext() {
        do {
            try AppDelegate.viewContext.save()
        } catch let error as NSError {
            print(error)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedFavoriteRecipeSegue",
            let detailedFavoriteRecipeVC = segue.destination as? DetailedFavoriteRecipeViewController,
            let indexPath = self.favoritesRecipesListTableView.indexPathForSelectedRow {
            index = indexPath.row
            detailedFavoriteRecipeVC.index = index
            let selectedFavoriteRecipe = favoritesRecipes[index]
            detailedFavoriteRecipeVC.detailedFavoriteRecipe = selectedFavoriteRecipe
            
        }
    }
}

extension FavoritesRecipesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesRecipes.count
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let label = UILabel()
        label.text = "Hit the favorite button to add a recipe in your favorite list!"
        label.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return favoritesRecipes.isEmpty ? 200 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = favoritesRecipesListTableView.dequeueReusableCell(withIdentifier: "favoriteRecipeCell", for: indexPath) as? FavoriteRecipeTableViewCell else {
            return UITableViewCell()
        }
        let favoriteRecipe = favoritesRecipes[indexPath.row]
        cell.selectionStyle = .none
        cell.favoriteRecipeCellConfigure(favoriteRecipeName: favoriteRecipe.recipeName!, favoriteRecipeDetails: favoriteRecipe.ingredients!, ratings: Int(favoriteRecipe.rating), timer: Int(favoriteRecipe.totalTimeInSeconds) / 60, backgroundRecipeImageURL: favoriteRecipe.image!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            AppDelegate.viewContext.delete(favoritesRecipes[indexPath.row])
            favoritesRecipes.remove(at: indexPath.row)
            saveContext()
            favoritesRecipesListTableView.beginUpdates()
            favoritesRecipesListTableView.deleteRows(at: [indexPath], with: .automatic)
            favoritesRecipesListTableView.endUpdates()
        }
    }
}


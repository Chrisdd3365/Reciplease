//
//  ResultRecipesListViewController.swift
//  Reciplease
//
//  Created by Christophe DURAND on 12/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

class ResultRecipesListViewController: UIViewController {
    //MARK: - Outlets
    @IBOutlet weak var resultRecipeListTableView: UITableView!
    
    //MARK: - Properties
    var matchingRecipesViewModels = [MatchingRecipesViewModel]()
    var detailedRecipeViewModel: DetailedRecipesViewModel?
    var detailedRecipeService = DetailedRecipeService()
  
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setResultRecipesTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resultRecipeListTableView.reloadData()
    }
    
    //MARK: - Methods
    //Method to display the navigation item's title
    private func setResultRecipesTableView() {
        self.navigationItem.title = "List of Recipes"
    }
    
    //Method to get the detailed recipe by tapping a cell into the table view
    private func getDetailsForRecipe(id: String) {
        detailedRecipeService.getDetailedRecipe(id: id) { (success, detailedRecipe)  in
            if success, let detailedRecipe = detailedRecipe {
                let detailedRecipesViewModel = DetailedRecipesViewModel(detailedRecipe: detailedRecipe)
                self.detailedRecipeViewModel = detailedRecipesViewModel
                self.performSegue(withIdentifier: SeguesIdentifiers.detailedRecipeSegueidentifier, sender: self)
            } else {
                self.showAlert(title: "Error", message: "Recipes Details data download failed!")
            }
        }
    }
    
    //Method to pass datas from the ResultRecipesListViewController to the DetailedRecipesViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SeguesIdentifiers.detailedRecipeSegueidentifier,
            let detailedRecipeVC = segue.destination as? DetailedRecipeViewController, let indexPath = self.resultRecipeListTableView.indexPathForSelectedRow {
            let selectedRecipe = matchingRecipesViewModels[indexPath.row]
            detailedRecipeVC.detailedRecipeViewModel = detailedRecipeViewModel
            detailedRecipeVC.matchingRecipeViewModel = selectedRecipe
        }
    }
}

//Extension to setup the resultRecipeListTableView
extension ResultRecipesListViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return matchingRecipesViewModels.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = resultRecipeListTableView.dequeueReusableCell(withIdentifier: CellsIdentifiers.recipeCellIdentifier, for: indexPath) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        
        let matchingRecipeViewModel = matchingRecipesViewModels[indexPath.row]
        cell.matchingRecipesViewModel = matchingRecipeViewModel
        cell.viewConfigure(view: cell.view)

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        getDetailsForRecipe(id: matchingRecipesViewModels[indexPath.row].id)
    }
}


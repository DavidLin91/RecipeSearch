//
//  RecipeSearchController.swift
//  RecipeSearch
//
//  Created by Alex Paul on 12/9/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

/*
TO DO: we need a table view
 we need a recipes array
 on the recipes array, have a didSet{} to update the tableview
 in cell for row, show the recipe's label
 RecipeSearchAPI.fetchRecipes accessing data to populate recipes array


*/
import UIKit

class RecipeSearchController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var recipes = [Recipe]() {
        didSet {  // property observer .. if recipes change, didSet will get called
            DispatchQueue.main.async {
            // use self b/c you're inside a closure
            self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "walnut shrimp"
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
        loadData(search: searchQuery)
    }
    
    func loadData(search: String) {
        RecipeSearchAPI.fetchRecipe(for: search) { (result) in
            switch result{
            case .failure(let appError):
                print("app error \(appError)")
            case .success(let data):
                self.recipes = data
            }
        }
    }
}

extension RecipeSearchController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as? RecipeCell else {
            fatalError("")
        }
        let recipe = recipes[indexPath.row]
        cell.configureCell(for: recipe)
        return cell
    }
}

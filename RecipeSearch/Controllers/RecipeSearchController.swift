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
    @IBOutlet weak var searchBar: UISearchBar!
    
    var recipes = [Recipe]() {
        didSet {  // property observer .. if recipes change, didSet will get called
            DispatchQueue.main.async {
                // use self b/c you're inside a closure
                self.tableView.reloadData()
            }
        }
    }
    
    var searchQuery = "penis"
    
    
    override func viewDidLoad() {
        super .viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        searchRecipes(search: searchQuery)
        
        // set navigation bar title
        navigationItem.title = "RECIPE SEARCH"
    }
    
    func searchRecipes(search: String){
        RecipeSearchAPI.fetchRecipe(for: search) { [weak self] (result) in
            switch result{
            case .failure(let appError):
                print("appError: \(appError)")
            case .success(let data):
                self?.recipes = data
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
            fatalError("could not dequeue a RecipeCell")
        }
        let recipe = recipes[indexPath.row]
        cell.configureCell(for: recipe)
        return cell
    }
}

extension RecipeSearchController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // we will use a guard let to unwrap the searchBar.text property because its an optional
        guard let searchText = searchBar.text else {
            print("missing search text")
            return
        }
        searchRecipes(search: searchText )
    }
}

extension RecipeSearchController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
}

//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by David Lin on 12/11/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {
    @IBOutlet weak var recipeImage: UIView!
    @IBOutlet weak var recipeName: UILabel!
    
    func configureCell( for recipe: Recipe) {
        recipeName.text = recipe.label
    }
}

//
//  RecipeCell.swift
//  RecipeSearch
//
//  Created by David Lin on 12/11/19.
//  Copyright © 2019 Alex Paul. All rights reserved.
//

import UIKit

class RecipeCell: UITableViewCell {

    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    
    func configureCell( for recipe: Recipe) {
        recipeName.text = recipe.label
        
        // set image for recipe
        // use a capture list ex: [weak self] or [unowned self] to break strong 9retain) reference cycles
        recipeImage.getImage(with: recipe.image) {[weak self] (result) in
            switch result {
            case .failure:
                DispatchQueue.main.async {
                    self?.recipeImage.image = UIImage(systemName: "exclaimationmark.triangle")
                }
            case .success(let image):
                DispatchQueue.main.async {
                    self?.recipeImage.image = image
                }
            }
        
        }
        
    }
}

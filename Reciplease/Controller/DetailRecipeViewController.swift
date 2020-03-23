//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Graphic Influence on 18/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import UIKit


class DetailRecipeViewController: UIViewController {
    @IBOutlet weak var recipeImageView: UIImageView!

    @IBOutlet weak var favoriteBarButton: UIBarButtonItem!

    @IBOutlet weak var ingredientsTextView: UITextView!

    @IBOutlet weak var recipeLabel: UILabel!
    var selectedRecipe: Hit?
    var vcOne: Bool = true
    var favoriteRecipe: FavoriteRecipes?

    override func viewDidLoad() {
        super.viewDidLoad()
        if vcOne {
            setUpViewfromSearch()
        } else {
            setupViewFromFavorites()
        }
        // Do any additional setup after loading the view.
    }

    func setUpViewfromSearch() {
        guard let recipe = selectedRecipe else { return }
        recipeLabel.text = recipe.recipe.label
        if let stringUrl = URL(string: recipe.recipe.image) {
            recipeImageView.load(url: stringUrl)
        }
        for (index,ingredients) in recipe.recipe.ingredientLines.enumerated() {
            ingredientsTextView.text += "\(index + 1) : \(ingredients)\n"
            print("\(index + 1) : \(ingredients)\n")
        }
    }

    func setupViewFromFavorites() {
        guard let recipe = favoriteRecipe else { return }
        recipeLabel.text = recipe.label
        guard let image = recipe.image else { return }
        if let stringUrl = URL(string: image) {
            recipeImageView.load(url: stringUrl)
        }
        guard let ingredients = recipe.ingredients else { return }
        ingredientsTextView.text += ingredients
        print(ingredients)
    }

    @IBAction func getDirectionsPressed(_ sender: UIButton) {
        guard let recipe = selectedRecipe else { return }
        guard let favoriteRecipe = favoriteRecipe else { return }
        if vcOne {
        guard let url = URL(string: recipe.recipe.url) else { return }
        UIApplication.shared.open(url)
        } else {
            guard let favoriteUrl = favoriteRecipe.url else { return }
            guard let url = URL(string: favoriteUrl) else { return }
            UIApplication.shared.open(url)
        }
    }
    @IBAction func favoritePressed(_ sender: UIBarButtonItem) {

        //        changer l'image du thumbs up
        guard let selectedRecipe = selectedRecipe else { return }
        let favoriteRecipe = FavoriteRecipes(context: AppDelegate.viewContext)
        favoriteRecipe.label = selectedRecipe.recipe.label
        favoriteRecipe.image = selectedRecipe.recipe.image
        favoriteRecipe.url = selectedRecipe.recipe.url
        for ingredient in selectedRecipe.recipe.ingredientLines {
            favoriteRecipe.ingredients = ingredient
        }
        do {
            try AppDelegate.viewContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }
}

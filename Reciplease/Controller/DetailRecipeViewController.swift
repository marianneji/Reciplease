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
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
                updateNavBar()
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        ingredientsTextView.setContentOffset(CGPoint.zero, animated: false)
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
        let ingredientsArray = ingredients.split(separator: ";")
        for (index, ingredients) in ingredientsArray.enumerated() {
            ingredientsTextView.text += "\(index + 1) : \(ingredients)\n"
        }
    }

    @IBAction func getDirectionsPressed(_ sender: UIButton) {

        if vcOne {
            guard let selectedURL = selectedRecipe?.recipe.url else { return }
            guard let url = URL(string: (selectedURL)) else { return }
            print(url)
            UIApplication.shared.open(url)

        } else {
            guard let favoriteUrl = favoriteRecipe?.url else { return }
            guard let url = URL(string: favoriteUrl) else { return }
            UIApplication.shared.open(url)
        }
    }

    func updateNavBar() {
        if selectedRecipe?.recipe.label.lowercased() == favoriteRecipe?.label?.lowercased() {
            favoriteBarButton.image = UIImage(named: "FullThumbsUp")

        } else {
            favoriteBarButton.image = UIImage(named: "ThumbsUp")
        }
    }

    @IBAction func favoritePressed(_ sender: UIBarButtonItem) {
        guard let selectedRecipe = selectedRecipe else { return }
        let favoriteRecipe = FavoriteRecipes(context: AppDelegate.viewContext)
        if sender.image == UIImage(named: "ThumbsUp") {
            sender.image = UIImage(named: "FullThumbsUp")
            favoriteRecipe.label = selectedRecipe.recipe.label
            favoriteRecipe.image = selectedRecipe.recipe.image
            favoriteRecipe.url = selectedRecipe.recipe.url
            favoriteRecipe.totalTime = String(selectedRecipe.recipe.totalTime)
            let ingredients = selectedRecipe.recipe.ingredientLines.joined(separator: ";")
            favoriteRecipe.ingredients = ingredients

            do {
                try AppDelegate.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        } else if sender.image == UIImage(named: "FullThumbsUp") {
            sender.image = UIImage(named: "ThumbsUp")
            AppDelegate.viewContext.delete(favoriteRecipe)
            do {
                try AppDelegate.viewContext.save()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

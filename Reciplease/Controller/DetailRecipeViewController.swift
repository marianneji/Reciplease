//
//  DetailRecipeViewController.swift
//  Reciplease
//
//  Created by Graphic Influence on 18/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import UIKit


class DetailRecipeViewController: UIViewController {


    var coreDataManager: CoreDataManager?

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
        guard let appdelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let coredataStack = appdelegate.coreDataStack
        coreDataManager = CoreDataManager(coreDataStack: coredataStack)
        view.snapshotView(afterScreenUpdates: true)

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
        print("updating nav bar")
        guard let recipeLabel = recipeLabel.text else {
            print("pas de recipeLabel???")
            return }
        guard let coreData = coreDataManager else {
            print("ou bien là dans updatNavBar avec coredatamanager")
            return}
        guard coreData.checkIfRecipeIsInFavorite(recipeLabel: recipeLabel) == true else {

            favoriteBarButton.image = UIImage(named: "ThumbsUp")
            return
        }
        favoriteBarButton.image = UIImage(named: "FullThumbsUp")
    }

    @IBAction func favoritePressed(_ sender: UIBarButtonItem) {
        if sender.image == UIImage(named: "FullThumbsUp") {
            sender.image = UIImage(named: "ThumbsUp")
            guard let coredata = coreDataManager else { print ("ça foire par là")
            return}
            coredata.deleteRecipeFromFavorite(recipeLabel: recipeLabel.text ?? "")
            navigationController?.popViewController(animated: true)
        } else 

        if sender.image == UIImage(named: "ThumbsUp") {
            sender.image = UIImage(named: "FullThumbsUp")
            print("ça marche ici")
            guard let coredata = coreDataManager else { print ("ça foire par là")
            return}
            guard let selectedRecipe = selectedRecipe else { return }
            print(selectedRecipe.recipe.label)
            let ingredients = selectedRecipe.recipe.ingredientLines.joined(separator: ";")

            coredata.addRecipesToFavorites(label: selectedRecipe.recipe.label, image: selectedRecipe.recipe.image, ingredients: ingredients, url: selectedRecipe.recipe.url, totalTime: String(selectedRecipe.recipe.totalTime))
            print(selectedRecipe.recipe.image)

        }

    }
    func deleteFromFavorites() {

    }
}

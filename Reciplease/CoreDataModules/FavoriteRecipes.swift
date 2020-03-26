//
//  FavoriteRecipes.swift
//  Reciplease
//
//  Created by Graphic Influence on 20/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import Foundation
import CoreData


class FavoriteRecipes: NSManagedObject {

}
final class CoreDataManager {

    // MARK: - Properties

    private let coreDataStack: CoreDataStack
    private let managedObjectContext: NSManagedObjectContext

    var favoriteRecipes: [FavoriteRecipes] {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
//        request.sortDescriptors = [NSSortDescriptor(key: "label", ascending: true)]
        guard let recipes = try? managedObjectContext.fetch(request) else { return [] }
        return recipes
    }

    // MARK: - Initializer

    init(coreDataStack: CoreDataStack) {
        self.coreDataStack = coreDataStack
        self.managedObjectContext = coreDataStack.mainContext
    }

    // MARK: - Manage Task Entity

    func addRecipesToFavorites(label: String, image: String, ingredients: String, url: String, totalTime: String) {
        let recipes = FavoriteRecipes(context: managedObjectContext)
        recipes.label = label
        recipes.image = image
        recipes.ingredients = ingredients
        recipes.url = url
        recipes.totalTime = totalTime
        coreDataStack.saveContext()
    }
    func deleteRecipeFromFavorite(recipeLabel: String) {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        let predicate = NSPredicate(format: "label == %@", recipeLabel)
        request.predicate = predicate
        if let objects = try? managedObjectContext.fetch(request) {
            objects.forEach { managedObjectContext.delete($0)}
        }
        coreDataStack.saveContext()
    }

    func deleteAllTasks() {
        favoriteRecipes.forEach { managedObjectContext.delete($0) }
        coreDataStack.saveContext()
    }
    func checkIfRecipeIsInFavorite(recipeLabel: String) -> Bool {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        request.predicate = NSPredicate(format: "label == %@", recipeLabel)
        guard let recipes = try? managedObjectContext.fetch(request) else { return false }
        if recipes.isEmpty {return false}
        return true
    }
}

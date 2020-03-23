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
        static var all: [FavoriteRecipes] {
        let request: NSFetchRequest<FavoriteRecipes> = FavoriteRecipes.fetchRequest()
        guard let recipes = try? AppDelegate.viewContext.fetch(request) else { return [] }
        return recipes
    }
}

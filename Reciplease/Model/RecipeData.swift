//
//  RecipeData.swift
//  Reciplease
//
//  Created by Graphic Influence on 13/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import Foundation

struct RecipeData: Codable {
    var hits: [Hit]
}

struct Hit: Codable {
    var recipe: Recipe
    var bookmarked: Bool
    var bought: Bool
}

struct Recipe: Codable {
    var uri: String
    var label: String
    var image: String
    var source: String
    var url: String
    var yield: Int
    var calories: Float
    var totalWeight: Float
    var totalTime: Float
    var ingredientLines: [String]
    var ingredients: [Ingredient]
    var totalNutrients: [NutrientInfo]
    var totalDaily: [NutrientInfo]
}

struct Ingredient: Codable {
    var foodId: String
    var quantity: Float
    var weight: Float
}

struct NutrientInfo: Codable {
    var uri: String
    var label: String
    var quantity: Float
    var unit: String
}

enum DietLabels: String {
    case balanced
    case highProtein = "high-protein"
    case highFiber = "high-fiber"
    case lowFat = "low-fat"
    case lowCarb = "low-carb"
    case lowSodium = "low-sodium"
}



//
//  SearchManager.swift
//  Reciplease
//
//  Created by Graphic Influence on 25/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

protocol RecipeManagerDelegate {
    func updateRecipe()
}

class RecipeSearchManager {

    private var shared = RecipeSearchManager()
    private init() {}

    var recipeManager: RecipeSearchManager?

    private let appID = ApiKeys.valueForApiKey(named: "app_id")
    private let appKey = ApiKeys.valueForApiKey(named: "app_key")
    static let recipeUrl = "https://api.edamam.com/search"

    

    func getRecipe(url: String, parameters: [String: String]) {
        request(url, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            if response.result.isSuccess {
                let recipeData = response.result.value!
            }
        }
    }
}

//
//  SearchManager.swift
//  Reciplease
//
//  Created by Graphic Influence on 25/12/2019.
//  Copyright © 2019 marianne massé. All rights reserved.
//

import Foundation
import Alamofire

class RecipeSearchManager {

    private var shared = RecipeSearchManager()
    private init() {}

    private let appID = ApiKeys.valueForApiKey(named: "app_id")
    private let appKey = ApiKeys.valueForApiKey(named: "app_key")
}

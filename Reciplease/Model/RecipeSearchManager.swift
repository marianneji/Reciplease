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

enum SearchError: Error {
    case noData, incorrectResponse, undecodable
}

class RecipeSearchManager: EncoderUrl {
    // MARK: - Properties

    private let session: AlamoSession
    static var messageError = ""

    // MARK: - Initializer

    init(session: AlamoSession = SearchSession()) {
        self.session = session
    }

    private let appID = ApiKeys.valueForApiKey(named: "app_id")
    private let appKey = ApiKeys.valueForApiKey(named: "app_key")

    func getRecipe(ingredients: String, callback: @escaping (Result<RecipeData>) -> Void) {
        guard let baseUrl = URL(string: "https://api.edamam.com/search") else { return }

        let parameters: [(String, String)] = [("q", ingredients), ("app_id", appID), ("app_key", appKey), ("to", "30")]
        let url = encode(baseUrl: baseUrl, parameters: parameters)
        print(url)
        session.request(with: url) { responseData in
            guard let data = responseData.data else {
                callback(.failure(SearchError.noData))
                RecipeSearchManager.messageError = "No data"
                return
            }
            guard responseData.response?.statusCode == 200 else {
                callback(.failure(SearchError.incorrectResponse))
                RecipeSearchManager.messageError = "No response... Check your internet connection"
                return
            }
            guard let dataDecoded = try? JSONDecoder().decode(RecipeData.self, from: data) else {
                callback(.failure(SearchError.undecodable))
                RecipeSearchManager.messageError = "Problem in decoding Data"
                return
            }
            callback(.success(dataDecoded))

        }
    }
}

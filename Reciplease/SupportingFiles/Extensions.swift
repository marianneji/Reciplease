//
//  Extensions.swift
//  Reciplease
//
//  Created by Graphic Influence on 16/03/2020.
//  Copyright © 2020 marianne massé. All rights reserved.
//

import Foundation
import UIKit

protocol EncoderUrl {
    func encode(baseUrl: URL, parameters: [(String, String)]) -> URL
}

/// Extension that configure the URLComponents by setting its queryItems property
extension EncoderUrl {
    func encode(baseUrl: URL, parameters: [(String, String)]) -> URL {
        guard var urlComponents = URLComponents(url: baseUrl, resolvingAgainstBaseURL: false) else { return baseUrl }
        urlComponents.queryItems = [URLQueryItem]()
        for (key, value) in parameters {
            let queryItem = URLQueryItem(name: key, value: value)
            urlComponents.queryItems?.append(queryItem)
        }
        guard let url = urlComponents.url else { return baseUrl }
        return url
    }
}
extension UIImageView {

    // MARK: - Properties

    /// Load url on UIImageview
    func load(url: URL) {
        guard let data = try? Data(contentsOf: url) else {return}
        guard let image = UIImage(data: data) else {return}
        DispatchQueue.main.async {
            self.image = image
        }
    }
}

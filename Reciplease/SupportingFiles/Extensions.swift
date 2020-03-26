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
//extension UIImage {
//  func resizeImage(targetSize: CGSize) -> UIImage {
//    let size = self.size
//    let widthRatio  = targetSize.width  / size.width
//    let heightRatio = targetSize.height / size.height
//    let newSize = widthRatio > heightRatio ?  CGSize(width: size.width * heightRatio, height: size.height * heightRatio) : CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
//    let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
//
//    UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
//    self.draw(in: rect)
//    let newImage = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    guard let image = newImage else { return UIImage() }
//
//    return image
//  }
//}
extension UIViewController {

    func didFailWithError(_ title: String? = "Error", message: String) {
        let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
        self.present(ac, animated: true)
    }

    func displayAlertActivity(alert: inout UIAlertController, title: String) {
        alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.isUserInteractionEnabled = false
        activityIndicator.startAnimating()
        alert.view.addSubview(activityIndicator)
        alert.view.heightAnchor.constraint(equalToConstant: 95).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: alert.view.centerXAnchor, constant: 0).isActive = true
        activityIndicator.bottomAnchor.constraint(equalTo: alert.view.bottomAnchor, constant: -20).isActive = true

        present(alert, animated: true, completion: nil)
    }

    func dismissAlertActivity(alert: UIAlertController, completion: (() -> Void)?) {
        alert.dismiss(animated: true, completion: completion)
    }
}

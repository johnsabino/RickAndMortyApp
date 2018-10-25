//
//  UIImageView+RickAndMortyApp.swift
//  RickAndMortyApp
//
//  Created by João Paulo on 18/10/18.
//  Copyright © 2018 João Paulo de Oliveira Sabino. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    static func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit,completion: @escaping (UIImage) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                completion(image)
                //self.image = image
            }
            }.resume()
    }
}

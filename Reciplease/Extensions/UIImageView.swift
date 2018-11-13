//
//  UIImageView.swift
//  Reciplease
//
//  Created by Christophe DURAND on 18/10/2018.
//  Copyright © 2018 Christophe DURAND. All rights reserved.
//

import UIKit

extension UIImageView {
    //Method to load an image from his URL and display it with better dimension
    func load(imageURL: String?) {
        guard let urlImageString = imageURL else { return }
        let urlImageStringHD = urlImageString.replacingOccurrences(of: "90", with: "900")
        guard let urlImage = URL(string: urlImageStringHD) else { return }
        DispatchQueue.global().async { [weak self] in
            guard let imageData = try? Data(contentsOf: urlImage) else { return }
            if let image = UIImage(data: imageData) {
                DispatchQueue.main.async {
                    self?.image = image
                }
            }
        }
    }
}

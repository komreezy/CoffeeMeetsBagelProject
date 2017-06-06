//
//  UIImageView+LoadImage.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/4/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

extension UIImageView {
    func loadImage(with urlString: String, completion: @escaping () -> ()) {
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            if error != nil {
                print("could not load image at \(urlString)")
                completion()
                return
            }
            
            DispatchQueue.main.async {
                guard let data = data, let image = UIImage(data: data) else { return }
                self.image = image
                completion()
            }
        }).resume()
    }
}

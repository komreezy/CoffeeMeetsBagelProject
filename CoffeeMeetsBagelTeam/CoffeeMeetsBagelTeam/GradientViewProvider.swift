//
//  GradientViewProvider.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/2/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

/**
 * source: https://medium.com/ios-os-x-development/swift-3-easy-gradients-54ccc9284ce4
 * for easy gradient data structures
 *
 * calculateGradient(for progress) function done by me on top of it
 */

struct RGB {
    var red: Float = 0.0
    var green: Float = 0.0
    var blue: Float = 0.0
}

protocol GradientViewProvider {
    associatedtype GradientViewType
    func calculateGradient(for progress: Float, with colors: RGB...)
}

extension GradientViewProvider where Self: UIView, Self.GradientViewType: CAGradientLayer {
    var gradientLayer: Self.GradientViewType {
        return layer as! Self.GradientViewType
    }
}

extension UIView: GradientViewProvider {
    func calculateGradient(for progress: Float, with colors: RGB...) {
        var newGradientColors: [CGColor] = []
        var rgbs: [RGB] = []
        
        for i in stride(from: 0, to: colors.count - 1, by: 1) {
            let newRed = (1.0 - progress) * colors[i].red + progress * colors[i+1].red
            let newGreen = (1.0 - progress) * colors[i].green + progress * colors[i].green
            let newBlue = (1.0 - progress) * colors[i].blue + progress * colors[i].blue
            rgbs.append(RGB(red: newRed, green: newGreen, blue: newBlue))
        }
        
        for rgb in rgbs {
            let newColor = UIColor(colorLiteralRed: rgb.red, green: rgb.green, blue: rgb.blue, alpha: 1.0).cgColor
            newGradientColors.append(newColor)
        }
        
        self.gradientLayer.colors = newGradientColors
    }
    
    typealias GradientViewType = GradientLayer
}

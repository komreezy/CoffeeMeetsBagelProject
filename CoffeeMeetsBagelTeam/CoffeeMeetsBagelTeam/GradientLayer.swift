//
//  GradientLayer.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/2/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

// source: https://medium.com/ios-os-x-development/swift-3-easy-gradients-54ccc9284ce4

class GradientLayer: CAGradientLayer {
    var gradient: GradientType? {
        didSet {
            startPoint = gradient?.x ?? CGPoint.zero
            endPoint = gradient?.y ?? CGPoint.zero
        }
    }
}

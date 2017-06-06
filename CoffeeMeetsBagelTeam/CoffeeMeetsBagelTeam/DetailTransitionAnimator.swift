//
//  FadeInTransitionAnimator.swift
//  CoffeeMeetsBagelTeam
//
//  Created by Komran Ghahremani on 6/4/17.
//  Copyright © 2017 Komran Ghahremani. All rights reserved.
//

import UIKit

class DetailTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    fileprivate let presenting: Bool
    fileprivate let duration: TimeInterval
    fileprivate let gradient: [CGColor]
    fileprivate let image: UIImage
    fileprivate let origin: CGPoint
    
    init(presenting: Bool, duration: TimeInterval = 0.15, gradient: [CGColor] = [], image: UIImage = UIImage(), origin: CGPoint = .zero) {
        self.presenting = presenting
        self.duration = duration
        self.gradient = gradient
        self.image = image
        self.origin = origin
    }
    
    @objc func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    @objc func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) else {
                return
        }
        
        let transitionContextContainerView = transitionContext.containerView
        let lastViewControllerFrame = fromViewController.view.frame
        
        let tintView = GradientView(frame: lastViewControllerFrame)
        tintView.gradientLayer.gradient = GradientPoint.topBottom.draw()
        tintView.gradientLayer.colors = gradient
        
        let profileImage = UIImageView(image: image)
        profileImage.layer.cornerRadius = 40.0
        profileImage.clipsToBounds = true
        profileImage.frame = CGRect(origin: origin, size: CGSize(width: 80.0, height: 80.0))
        
        if presenting {
            transitionContextContainerView.addSubview(tintView)
            transitionContextContainerView.addSubview(toViewController.view)
            transitionContextContainerView.addSubview(profileImage)
            
            toViewController.view.frame = lastViewControllerFrame
            toViewController.view.alpha = 0
        }
        
        UIView.animate(withDuration: duration, delay: 0.0, options: .curveEaseIn, animations: {
            if self.presenting {
                fromViewController.view.isUserInteractionEnabled = false
                fromViewController.view.tintAdjustmentMode = .normal
                
                profileImage.frame = CGRect(x: toViewController.view.frame.width / 2 - 60.0, y: 66.0, width: 120.0, height: 120.0)
                profileImage.layer.cornerRadius = 60.0
            } else {
                transitionContextContainerView.alpha = 0
                toViewController.view.isUserInteractionEnabled = true
                toViewController.view.tintAdjustmentMode = .automatic
                fromViewController.view.alpha = 0
            }
        }, completion: { success in
            UIView.animate(withDuration: 0.4, animations: {
                toViewController.view.alpha = 1
                profileImage.alpha = 0
            })
            transitionContext.completeTransition(success)
        })
    }
}

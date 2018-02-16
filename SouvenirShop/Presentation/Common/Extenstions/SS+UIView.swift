//
//  SS+UIView.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


extension UIView {
    
    func round(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    func border(color: UIColor, width: CGFloat = 1) {
        layer.borderColor = color.cgColor
        layer.borderWidth = width
    }
    
    func gradient(colors: [CGColor], direction: GradientDirection) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = direction.rawValue.start
        gradientLayer.endPoint = direction.rawValue.end
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func fadeTransition(duration: CFTimeInterval = K.Duration.Animation) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.type = kCATransitionFade
        animation.duration = duration
        layer.add(animation, forKey: kCATransitionFade)
    }
}

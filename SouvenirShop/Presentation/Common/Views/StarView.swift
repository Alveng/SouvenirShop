//
//  StarView.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 15.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


class StarView: UIView {
    
    private var pathLayer: CAShapeLayer?
    private let angle: CGFloat
    var size: CGFloat = 35 {
        didSet {
            let rect = CGRect(x: frame.origin.x, y: frame.origin.y, width: size, height: size)
            pathLayer?.removeFromSuperlayer()
            addStarLayer(frame: rect)
        }
    }
    
    init(rotateAngle: CGFloat) {
        self.angle = rotateAngle
        let frame = CGRect(x: 0, y: 0, width: size, height: size)
        super.init(frame: frame)
        
        addStarLayer(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func addStarLayer(frame: CGRect) {
        pathLayer = starLayer(frame: frame)
        layer.addSublayer(pathLayer!)
        transform = transform.rotated(by: angle.degreeFromRadian())
    }
    
    private func starLayer(frame: CGRect) -> CAShapeLayer {
        let layer = CAShapeLayer()
        let path = starPathInRect(rect: frame)
        layer.path = path.cgPath
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        layer.lineWidth = 2
        return layer
    }
    
    private func starPathInRect(rect: CGRect) -> UIBezierPath {
        let path = UIBezierPath()
        let starExtrusion: CGFloat = size / 4
        let center = CGPoint(x: rect.width / 2, y: rect.height / 2)
        let pointsOnStar = 5
        var angle: CGFloat = -CGFloat(Double.pi / 2.0)
        let angleIncrement = CGFloat(Double.pi * 2.0 / Double(pointsOnStar))
        let radius = rect.width / 2.0
        var firstPoint = true
        
        for _ in 1...pointsOnStar {
            let point = pointFrom(angle: angle, radius: radius, offset: center)
            let nextPoint = pointFrom(angle: angle + angleIncrement, radius: radius, offset: center)
            let midPoint = pointFrom(angle: angle + angleIncrement / 2.0, radius: starExtrusion, offset: center)
            
            if firstPoint {
                firstPoint = false
                path.move(to: point)
            }
            
            path.addLine(to: midPoint)
            path.addLine(to: nextPoint)
            
            angle += angleIncrement
        }
        path.close()
        return path
    }
    
    private func pointFrom(angle: CGFloat, radius: CGFloat, offset: CGPoint) -> CGPoint {
        return CGPoint(x: radius * cos(angle) + offset.x, y: radius * sin(angle) + offset.y)
    }
}

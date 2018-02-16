//
//  GradientDirection.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


enum GradientDirection: Points {
    case right = "{0.0, 0.5}; {1.0, 0.5}"
    case left = "{1.0, 0.5}; {0.0, 0.5}"
    case bottom = "{0.5, 0.0}; {0.5, 1.0}"
    case top = "{0.5, 1.0}; {0.5, 0.0}"
    case topLeftToBottomRight = "{0.0, 0.0}; {1.0, 1.0}"
    case topRightToBottomLeft = "{1.0, 0.0}; {0.0, 1.0}"
    case bottomLeftToTopRight = "{0.0, 1.0}; {1.0, 0.0}"
    case bottomRightToTopLeft = "{1.0, 1.0}; {0.0, 0.0}"
}

struct Points {
    let start: CGPoint
    let end: CGPoint
    
    init(start: CGPoint, end: CGPoint) {
        self.start = start
        self.end = end
    }
    
    init(points: [CGPoint]) {
        precondition(points.count == 2)
        
        self.init(start: points[0], end: points[1])
    }
}

extension Points: ExpressibleByStringLiteral {
    typealias StringLiteralType = String
    
    init(stringLiteral value: String) {
        let points = value.split(separator: ";")
            .map({ CGPointFromString(String($0)) })
            .filter({ $0 != nil })
        
        self.init(points: points)
    }
}

extension Points: Equatable {
    public static func ==(lhs: Points, rhs: Points) -> Bool {
        return lhs.start == rhs.start
            && lhs.end == rhs.end
    }
}

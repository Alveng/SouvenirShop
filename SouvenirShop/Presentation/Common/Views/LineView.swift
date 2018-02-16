//
//  LineView.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 15.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


class LineView: UIView {
    
    let width: CGFloat = 4
    
    init(rotateAngle: CGFloat) {
        let frame = CGRect(x: 0, y: 0, width: width, height: 0)
        super.init(frame: frame)
        
        backgroundColor = .white
        transform = transform.rotated(by: rotateAngle.degreeFromRadian())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

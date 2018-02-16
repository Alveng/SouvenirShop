//
//  SS+CGFloat.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 15.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


extension CGFloat {
    
    func degreeFromRadian() -> CGFloat {
        return (self * CGFloat(Double.pi / 180))
    }
}

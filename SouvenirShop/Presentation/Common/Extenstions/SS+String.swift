//
//  SS+String.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


extension String {
    
    func width(with label: UILabel) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: label.bounds.height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: label.font], context: nil)
        
        return ceil(boundingBox.width)
    }
}

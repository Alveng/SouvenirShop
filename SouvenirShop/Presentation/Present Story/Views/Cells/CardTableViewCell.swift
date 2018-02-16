//
//  CardTableViewCell.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var cardBrandImage: UIImageView!
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var card: PaymentCard? {
        didSet {
            guard let card = card else { return }
            
            numberLabel.text = "**** **** **** \(card.last4Numbers)"
            cardBrandImage.image = card.brand == .visa ? #imageLiteral(resourceName: "ic_visa") : #imageLiteral(resourceName: "ic_mastercard")
        }
    }
    
    var isSelectedCard: Bool = false {
        didSet {
            selectedImageView.isHidden = !isSelectedCard
        }
    }
}

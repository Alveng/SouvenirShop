//
//  PaymentCard.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation
import Stripe


enum CardBrand: String, Codable {
    case visa
    case mastercard
}

struct PaymentCard: Codable {
    var tokenId: String
    let last4Numbers: String
    let expMonth: UInt
    let expYear: UInt
    let cardHolderName: String?
    var brand: CardBrand?
    
    init(tokenId: String, card: STPCard) {
        self.tokenId = tokenId
        self.last4Numbers = card.last4
        self.expMonth = card.expMonth
        self.expYear = card.expYear
        self.cardHolderName = card.name
        
        switch card.brand {
        case .visa:       self.brand = .visa
        case .masterCard: self.brand = .mastercard
        default: break
        }
    }
}

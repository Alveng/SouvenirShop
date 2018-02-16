//
//  AddCardInteractor.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation
import Stripe


class AddCardInteractor {
    
    var cardParams: STPCardParams?
    
    func saveCard(completion: @escaping () -> (), failure: @escaping (Error) -> ()) {
        guard cardParams != nil else { return }
        
        STPAPIClient.shared().createToken(withCard: cardParams!) { (token: STPToken?, error: Error?) in
            guard let token = token, let card = token.card, error == nil else {
                failure(error!)
                return
            }
            
            let paymentCard = PaymentCard(tokenId: token.tokenId, card: card)
            let dao = UserDefaultsDAO<PaymentCard>()
            dao.persist(object: paymentCard)
            completion()
        }
    }
}

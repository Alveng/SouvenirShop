//
//  ObtainCardsInteractor.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


class ObtainCardsInteractor {
    
    func obtainCards() -> [PaymentCard] {
        let dao = UserDefaultsDAO<PaymentCard>()
        return dao.collection()
    }
}

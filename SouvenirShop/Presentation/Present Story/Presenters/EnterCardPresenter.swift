//
//  EnterCardPresenter.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation
import Stripe


protocol EnterCardModuleInterface: class {
    func addNewCard(number: String?, month: UInt, year: UInt, cvc: String?, holder: String?)
    func closeScreen()
}

class EnterCardPresenter {
    
    let interactor = AddCardInteractor()
    weak var view: EnterCardViewInterface!
    var router: EnterCardRouterInput!
    
    init(view: EnterCardViewInterface, router: EnterCardRouterInput) {
        self.view = view
        self.router = router
    }
}

extension EnterCardPresenter: EnterCardModuleInterface {
    
    func addNewCard(number: String?, month: UInt, year: UInt, cvc: String?, holder: String?) {
        router.startLoading()
        let cardParams = STPCardParams()
        cardParams.number = number
        cardParams.expMonth = month
        cardParams.expYear = year
        cardParams.cvc = cvc
        cardParams.name = holder
        
        interactor.cardParams = cardParams
        interactor.saveCard(completion: router.close, failure: router.show(error:))
    }
    
    func closeScreen() {
        router.close()
    }
}

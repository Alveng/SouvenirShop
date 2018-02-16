//
//  ChooseCardPresenter.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Foundation


protocol ChooseCardModuleInterface: class {
    func configureView()
    func updateCards()
    func selectCard(index: Int)
    func selectExpandCards()
    func buyPresent()
    func moveToAddNewCard()
    func closeScreen()
}

class ChooseCardPresenter {
    
    weak var view: ChooseCardViewInterface!
    var router: ChooseCardRouterInput!
    let daoInteractor = ObtainCardsInteractor()
    let buyInteractor = BuyPresentInteractor()
    
    let present: Present
    let presentIndex: Int
    var cards: [PaymentCard] = []
    var selectedCardIndex: Int?
    
    init(present: Present, presentIndex: Int, view: ChooseCardViewInterface, router: ChooseCardRouterInput) {
        self.view = view
        self.router = router
        self.present = present
        self.presentIndex = presentIndex
    }
}

extension ChooseCardPresenter: ChooseCardModuleInterface {
    
    func configureView() {
        view.configure(for: present, with: presentIndex)
    }
    
    func updateCards() {
        cards = daoInteractor.obtainCards()
        
        if cards.count > 0 {
            selectedCardIndex = 0
            view.showSelected(card: cards[selectedCardIndex!])
        } else {
            view.showAddingCard()
        }
    }
    
    func selectCard(index: Int) {
        selectedCardIndex = index
        view.showSelected(card: cards[selectedCardIndex!])
    }
    
    func selectExpandCards() {
        view.showExpandedMenu(cards: cards)
    }
    
    func buyPresent() {
        guard selectedCardIndex != nil else { return }
        
        router.startLoading()
        buyInteractor.buy(present: present, for: cards[selectedCardIndex!], completion: router.showAlert(with:message:), failure: router.show(error:))
    }
    
    func moveToAddNewCard() {
        router.presentAddingCard()
    }
    
    func closeScreen() {
        router.close()
    }
}

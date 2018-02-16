//
//  ChooseCardRouter.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


protocol ChooseCardRouterInput: RouterNavigationable, RouterLoadingable, RouterErrorable {
    func presentAddingCard()
}

class ChooseCardRouter: Router {
}

extension ChooseCardRouter: ChooseCardRouterInput {
    
    func presentAddingCard() {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EnterCardViewController") as? EnterCardViewController else {
            return
        }
        
        let router = EnterCardRouter(vc: vc)
        vc.presenter = EnterCardPresenter(view: vc, router: router)
        DispatchQueue.main.async {
            self.vc.present(vc, animated: true, completion: nil)
        }
    }
}

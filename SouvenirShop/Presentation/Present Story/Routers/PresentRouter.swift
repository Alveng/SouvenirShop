//
//  PresentRouter.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


protocol PresentRouterInput {
    func buying(present: Present, with index: Int)
}

class PresentRouter: Router {
}

extension PresentRouter: PresentRouterInput {
    
    // TODO: вынести инициализацию сторибордов и экранов
    func buying(present: Present, with index: Int) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ChooseCardViewController") as? ChooseCardViewController else {
            return
        }
        vc.modalPresentationStyle = .custom
        vc.modalTransitionStyle = .crossDissolve
        
        let router = ChooseCardRouter(vc: vc)
        vc.presenter = ChooseCardPresenter(present: present, presentIndex: index, view: vc, router: router)
        
        self.vc.present(vc, animated: true, completion: nil)
    }
}

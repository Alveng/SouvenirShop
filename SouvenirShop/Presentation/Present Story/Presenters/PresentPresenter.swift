//
//  PresentPresenter.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


protocol PresentsModuleInterface: class {
    func updateView()
    func send(present: Present, with index: Int)
}

class PresentPresenter {
    
    weak var view: PresentViewInterface!
    var router: PresentRouterInput!
    
    init(view: PresentViewInterface) {
        self.view = view
        if let vc = view as? UIViewController {
            router = PresentRouter(vc: vc)
        }
    }
}

extension PresentPresenter: PresentsModuleInterface {
    
    func updateView() {
        let presents = [Present(price: 10, size: "Small", image: #imageLiteral(resourceName: "img_small_gift")),
                        Present(price: 50, size: "Medium", image: #imageLiteral(resourceName: "img_medium_gift")),
                        Present(price: 100, size: "Big", image: #imageLiteral(resourceName: "img_large_gift"))]
        view.show(presents: presents)
    }
    
    func send(present: Present, with index: Int) {
        router.buying(present: present, with: index)
    }
}

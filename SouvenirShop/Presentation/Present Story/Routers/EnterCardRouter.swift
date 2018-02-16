//
//  EnterCardRouter.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


protocol EnterCardRouterInput: RouterNavigationable, RouterLoadingable, RouterErrorable {
}

class EnterCardRouter: Router {
}

extension EnterCardRouter: EnterCardRouterInput {
}

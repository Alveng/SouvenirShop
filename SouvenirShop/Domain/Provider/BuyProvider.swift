//
//  BuyProvider.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Moya


enum BuyProvider: BaseProvider {
    case buy(params: [String: Any])
}

extension BuyProvider: TargetType {
    
    var path: String {
        switch self {
        case .buy:
            return K.ApiKey.Donate
        }
    }
    
    var task: Task {
        return .requestParameters(parameters: parameters, encoding: parameterEncoding)
    }
    
    var parameters: [String: Any] {
        switch self {
        case .buy(let params):
            return params
        }
    }
}

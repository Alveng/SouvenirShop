//
//  BuyPresentInteractor.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import Moya
import RxSwift


class BuyPresentInteractor {
    
    private let provider = MoyaProvider<BuyProvider>(plugins: [NetworkLoggerPlugin(verbose: true, cURL: true)])
    let disposeBag = DisposeBag()
    
    func buy(present: Present, for card: PaymentCard, completion: @escaping (_ title: String?, _ message: String?) -> (), failure: @escaping (Error) -> ()) {
        // TODO: add request model + parsing response model
        let params: [String : Any] = ["stripeToken": card.tokenId,
                                      "amount": present.price,
                                      "currency": "usd",
                                      "description": present.size]
        
        provider.rx
            .request(.buy(params: params))
            .subscribe(onSuccess: { (response) in
                if let json = try? JSONSerialization.jsonObject(with: response.data, options: []) as? [String: String] {
                    completion(json?["status"], json?["message"])
                }
                completion("Fail", "Can't parse the response")
            }, onError: failure)
            .disposed(by: disposeBag)
    }
}

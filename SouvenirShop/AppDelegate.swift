//
//  AppDelegate.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 12.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit
import Stripe


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        if let value = ProcessInfo.processInfo.environment["stripe_key"] {
            STPPaymentConfiguration.shared().publishableKey = value
        } else {
            print("ERROR! You should add env var to connect API")
        }
        
        
        return true
    }
}


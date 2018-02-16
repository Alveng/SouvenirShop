//
//  Constants.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


enum K {
    
    enum DAO {
        static let Cards = "Cards"
    }
    
    enum ApiKey {
        static let BaseUrl = "http://localhost/donate/"
        static let Donate = "payment.php"
    }
    
    enum Error {
        static let Title = "Ошибка"
        static let OkAction = "ОК"
    }
    
    enum Duration {
        static let Animation = 0.4
    }
    
    enum Cells {
        static let Card = "CardTableViewCell"
        static let AddNewCard = "AddNewCardTableViewCell"
    }
    
    enum Size {
        static let CardCell: CGFloat = 50
        static let PresentLabelOffset: CGFloat = 40
    }
}

//
//  CardView.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class CardView: UIView {

    @IBOutlet private var contentView: UIView!
    @IBOutlet private weak var cardNumberLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var cvcLabel: UILabel!
    @IBOutlet private weak var cardHolderLabel: UILabel!
    
    var isDataReady = Variable(false)
    let disposeBag = DisposeBag()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed(String(describing: self.classForCoder), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        round(radius: 8)
        
        subscribeToEvents()
    }
    
    private func subscribeToEvents() {
        let cardValidation = cardNumberLabel.rx
            .observe(String.self, "text")
            .filter({ $0 != nil })
            .map({!$0!.isEmpty})
            .share(replay: 1)
        
        let dateValidation = dateLabel.rx
            .observe(String.self, "text")
            .filter({ $0 != nil })
            .map({!$0!.isEmpty})
            .share(replay: 1)
        
        let cvcValidation = cvcLabel.rx
            .observe(String.self, "text")
            .filter({ $0 != nil })
            .map({!$0!.isEmpty})
            .share(replay: 1)
        
        let enable = Observable.combineLatest(cardValidation, dateValidation, cvcValidation) { $0 && $1 && $2 }
        enable.bind(to: isDataReady).disposed(by: disposeBag)
    }
    
    func flipCard() {
        contentView.gradient(colors: [UIColor.ssLightBlue.cgColor, UIColor.ssDarkBlue.cgColor], direction: .right)
        UIView.transition(with: contentView, duration: 0.5, options: .transitionFlipFromTop, animations: nil, completion: nil)
    }
    
    func set(cardNumber: String?) {
        guard let number = cardNumber else { return }
        
        let maskedNumber = number.enumerated().map { (arg) -> String in
            let (index, element) = arg
            return index % 4 == 0 ? " \(element)" : String(element)
        }.joined()
        cardNumberLabel.text = maskedNumber
    }
    
    func set(month: String?, year: String?) {
        guard let month = month, let year = year else { return }
        
        let result = !year.isEmpty ? "\(month)/\(year)" : month
        dateLabel.text = result
    }
    
    func set(cvc: String?) {
        guard let cvc = cvc else { return }
        
        cvcLabel.text = cvc
    }
    
    func set(cardHolder: String?) {
        guard let holder = cardHolder else { return }
        
        cardHolderLabel.text = holder
    }
    
    func enableDateLabel() {
        dateLabel.isEnabled = true
    }
    
    func enableCvcLabel() {
        cvcLabel.isEnabled = true
    }
    
    func enableCardHolderLabel() {
        cardHolderLabel.isEnabled = true
    }
}

//
//  EnterCardViewController.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit
import Stripe
import RxSwift
import RxCocoa


protocol EnterCardViewInterface: class {
}

class EnterCardViewController: ViewController {
    
    @IBOutlet weak var cardView: CardView!
    @IBOutlet weak var textFieldContainerView: UIView!
    @IBOutlet weak var cardHolderTextField: UITextField!
    @IBOutlet weak var addCardButton: UIButton!
    
    var presenter: EnterCardModuleInterface!
    
    let cardField = STPPaymentCardTextField()
    let theme = STPTheme()
    let isDataReady = Variable(false)
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField()
        subscribeToEvents()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        cardField.becomeFirstResponder()
        cardView.flipCard()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        cardField.frame = textFieldContainerView.bounds
    }
    
    private func configureTextField() {
        textFieldContainerView.addSubview(cardField)
        cardField.backgroundColor = theme.secondaryBackgroundColor
        cardField.textColor = theme.primaryForegroundColor
        cardField.placeholderColor = theme.secondaryForegroundColor
        cardField.borderColor = theme.accentColor
        cardField.borderWidth = 1.0
        cardField.textErrorColor = theme.errorColor
        cardField.delegate = self
        
        cardHolderTextField.delegate = self
        cardHolderTextField.border(color: theme.accentColor)
        cardHolderTextField.round(radius: cardField.cornerRadius)
    }
    
    private func subscribeToEvents() {
        let cardHolderValidation = cardHolderTextField.rx
            .text
            .filter({ $0 != nil })
            .map({!$0!.isEmpty})
            .share(replay: 1)
        
        let buttonEnabled = Observable
            .combineLatest(cardView.isDataReady.asObservable(), cardHolderValidation) { $0 && $1 }
        buttonEnabled
            .bind(to: addCardButton.rx.isEnabled)
            .disposed(by: disposeBag)
        
        cardHolderTextField.rx
            .text
            .skip(2)
            .filter({ $0 != nil })
            .subscribe(onNext:{ [weak self] (typedText) in
                self?.cardView.set(cardHolder: typedText)
            }).disposed(by: disposeBag)
    }
    
    @IBAction func closeScreen(_ sender: Any) {
        presenter.closeScreen()
    }
    
    @IBAction func addCard(_ sender: Any) {
        presenter.addNewCard(number: cardField.cardNumber,
                             month: cardField.expirationMonth,
                             year: cardField.expirationYear,
                             cvc: cardField.cvc,
                             holder: cardHolderTextField.text)
    }
}

extension EnterCardViewController: EnterCardViewInterface {
}

extension EnterCardViewController: STPPaymentCardTextFieldDelegate {
    
    func paymentCardTextFieldDidChange(_ textField: STPPaymentCardTextField) {
        cardView.set(cardNumber: textField.cardNumber)
        cardView.set(month: textField.formattedExpirationMonth, year: textField.formattedExpirationYear)
        cardView.set(cvc: textField.cvc)
        
        if textField.cvc?.count == 3 {
            cardHolderTextField.isEnabled = true
            cardHolderTextField.becomeFirstResponder()
            cardView.enableCardHolderLabel()
        }
    }
    
    func paymentCardTextFieldDidBeginEditingExpiration(_ textField: STPPaymentCardTextField) {
        cardView.enableDateLabel()
    }
    
    func paymentCardTextFieldDidBeginEditingCVC(_ textField: STPPaymentCardTextField) {
        cardView.enableCvcLabel()
    }
}

extension EnterCardViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return true
    }
}

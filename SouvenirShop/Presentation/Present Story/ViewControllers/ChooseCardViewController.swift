//
//  ChooseCardViewController.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 13.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


protocol ChooseCardViewInterface: class {
    func configure(for present: Present, with index: Int)
    func showAddingCard()
    func showSelected(card: PaymentCard)
    func showExpandedMenu(cards: [PaymentCard])
}

class ChooseCardViewController: ViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var payButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var presentView: AnimatedPresentView!
    
    var presenter: ChooseCardPresenter!
    var showedCells: [PaymentCard?] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadCellNibs()
        presenter.configureView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter.updateCards()
    }
    
    private func loadCellNibs() {
        tableView.register(UINib(nibName: K.Cells.Card, bundle: nil), forCellReuseIdentifier: K.Cells.Card)
        tableView.register(UINib(nibName: K.Cells.AddNewCard, bundle: nil), forCellReuseIdentifier: K.Cells.AddNewCard)
    }
    
    private func updateTable(with shadow: Bool) {
        tableViewHeight.constant = K.Size.CardCell * CGFloat(showedCells.count)
        shadowView.backgroundColor = shadow ? .ssShadow : .clear
        shadowView.isUserInteractionEnabled = shadow
        tableView.fadeTransition()
        shadowView.fadeTransition()
        tableView.reloadData()
    }
    
    @IBAction func payForPresent(_ sender: Any) {
        presenter.buyPresent()
    }
    
    @IBAction func closeScreen(_ sender: Any) {
        presenter.closeScreen()
    }
}

extension ChooseCardViewController: ChooseCardViewInterface {
    
    func configure(for present: Present, with index: Int) {
        priceLabel.text = "\(present.price) EUR"
        payButton.setTitle("PAY \(present.price) EUR", for: .normal)
        presentView.currentAnimationIndex = index
        presentView.setupScreen(with: present)
    }
    
    func showAddingCard() {
        showedCells = [nil]
        updateTable(with: false)
    }
    
    func showSelected(card: PaymentCard) {
        showedCells = [card]
        updateTable(with: false)
    }
    
    func showExpandedMenu(cards: [PaymentCard]) {
        showedCells = cards
        showedCells.append(nil)
        updateTable(with: true)
    }
}

// TODO: управление таблицей передать отдельному компоненту, логику заполнения и табов реализовать на базовом уровне с моделями ячеек
extension ChooseCardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showedCells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        if let item = showedCells[indexPath.row] {
            let cardCell = tableView.dequeueReusableCell(withIdentifier: K.Cells.Card, for: indexPath) as! CardTableViewCell
            cardCell.card = item
            cardCell.isSelectedCard = presenter.selectedCardIndex == indexPath.row
            cell = cardCell
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.AddNewCard, for: indexPath)
        }
        return cell
    }
}

extension ChooseCardViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showedCells[indexPath.row] != nil {
            if showedCells.count > 1 {
                presenter.selectCard(index: indexPath.row)
            } else {
                presenter.selectExpandCards()
            }
        } else {
            presenter.moveToAddNewCard()
        }
    }
}

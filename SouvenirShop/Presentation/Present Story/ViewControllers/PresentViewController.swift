//
//  ViewController.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 12.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


protocol PresentViewInterface: class {
    func show(presents: [Present])
}

class PresentViewController: ViewController {
    
    @IBOutlet var rightSwipeGR: UISwipeGestureRecognizer!
    @IBOutlet var leftSwipeGR: UISwipeGestureRecognizer!
    
    @IBOutlet weak var presentContainerView: AnimatedPresentView!
    @IBOutlet weak var sumLabel: UILabel!
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var sendButton: UIButton!
    
    var presenter: PresentsModuleInterface!
    
    var presents: [Present] = []
    var currentIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PresentPresenter(view: self)
        presenter.updateView()
    }
    
    func updateScreen() {
        changeSum()
        changeButtonTitle()
        pageControl.currentPage = currentIndex
    }
    
    @IBAction func moveToNext(_ sender: UISwipeGestureRecognizer) {
        guard currentIndex < presents.count-1 else { return }
        
        currentIndex += 1
        updateScreen()
        presentContainerView.next(present: presents[currentIndex])
    }
    
    @IBAction func moveToPrevious(_ sender: UISwipeGestureRecognizer) {
        guard currentIndex > 0 else { return }
        
        currentIndex -= 1
        updateScreen()
        presentContainerView.previous(present: presents[currentIndex])
    }
    
    func changeSum() {
        sumLabel.fadeTransition()
        sumLabel.text = "\(presents[currentIndex].price) EUR"
    }
    
    func changeButtonTitle() {
        sendButton.fadeTransition()
        sendButton.setTitle("SEND \(presents[currentIndex].size.uppercased()) SOUVENIR", for: .normal)
    }
    
    @IBAction func sendPresent(_ sender: Any) {
        presenter.send(present: presents[currentIndex], with: currentIndex)
    }
}

extension PresentViewController: PresentViewInterface {
    
    func show(presents: [Present]) {
        self.presents = presents
        pageControl.numberOfPages = presents.count
        updateScreen()
        presentContainerView.setupScreen(with: presents[currentIndex])
    }
}


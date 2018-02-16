//
//  AnimatedPresentView.swift
//  SouvenirShop
//
//  Created by Sergey Klimov on 14.02.2018.
//  Copyright © 2018 Sergey Klimov. All rights reserved.
//

import UIKit


class AnimatedPresentView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var presentImage: UIImageView!
    @IBOutlet weak var presentNameLabel: UILabel!
    @IBOutlet weak var labelContainerWidth: NSLayoutConstraint!
    
    var animationDuration = K.Duration.Animation
    
    var currentShineViews: [LineView] = []
    var currentStarViews: [StarView] = []
    var currentAnimationIndex = 0
    
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
    }
    
    func setupScreen(with present: Present) {
        addShine()
        change(by: present, animation: false)
    }
    
    func next(present: Present) {
        currentAnimationIndex += 1
        change(by: present, animation: true)
    }
    
    func previous(present: Present) {
        currentAnimationIndex -= 1
        change(by: present, animation: true)
    }
    
    private func change(by present: Present, animation: Bool) {
        animationDuration = animation ? K.Duration.Animation : 0
        let title = "\(present.size) Souvenir"
        presentNameLabel.text = title
        
        presentNameLabel.fadeTransition()
        changeLabelWidth(by: title)
        changeImageSize(present.image)
        
        switch currentAnimationIndex {
            case 0: firstStage()
            case 1: secondStage()
            case 2: thirdStage()
            default: break
        }
    }
    
    private func changeLabelWidth(by title: String) {
        let newWidth = title.width(with: presentNameLabel) + K.Size.PresentLabelOffset
        labelContainerWidth.constant = newWidth
        UIView.animate(withDuration: animationDuration, animations: {
            self.layoutIfNeeded()
        })
    }
    
    private func changeImageSize(_ new: UIImage) {
        guard let old = presentImage.image else { return }
        
        let relativeDiffHeight = old.size.height / new.size.height
        let relativeDiffWidth = old.size.width / new.size.width
        let diffHeight = old.size.height - new.size.height
        
        let originalTransform = self.presentImage.transform
        let translatedTransform = originalTransform.translatedBy(x: 0.0, y: diffHeight / 2)
        let scaledAndTranslatedTransform = translatedTransform.scaledBy(x: 1/relativeDiffWidth, y: 1/relativeDiffHeight)
        
        UIView.animate(withDuration: animationDuration, animations: {
            self.presentImage.transform = scaledAndTranslatedTransform
        }, completion: { _ in
            self.presentImage.image = new
            self.presentImage.transform = CGAffineTransform.identity
        })
    }
    
    private func addShine() {
        let barAngles: [CGFloat] = [-55, -25, 0, 25, 55]
        let starAngles: [CGFloat] = [-63, -40, -12, -40, -40]
        
        for index in 0..<5 {
            let bar = LineView(rotateAngle: barAngles[index])
            let star = StarView(rotateAngle: starAngles[index])
            contentView.addSubview(bar)
            contentView.addSubview(star)
            currentShineViews.append(bar)
            currentStarViews.append(star)
        }
    }
    
    private func firstStage() {
        let width: CGFloat = contentView.frame.width / 3
        let step: CGFloat = width / 4
        let startX: CGFloat = (contentView.frame.width - width) / 2
        let botLevel: CGFloat = contentView.frame.height - 101
        let heights: [CGFloat] = [19, 22, 25, 22, 19]
        let barY: [CGFloat] = [botLevel - 15, botLevel - 35, botLevel - 40, botLevel - 35, botLevel - 15]
        let starY: [CGFloat] = [botLevel, botLevel, botLevel - 40, botLevel, botLevel]
        let visibles = [true, true, true, true, true]
        
        animateStages(startX: startX, stepX: step, heights: heights, barYs: barY, starYs: starY, visibles: visibles)
    }
    
    private func secondStage() {
        let width: CGFloat = contentView.frame.width / 2
        let step: CGFloat = width / 4
        let startX: CGFloat = (contentView.frame.width - width) / 2
        let botLevel: CGFloat = contentView.frame.height - 135
        let heights: [CGFloat] = [28, 30, 35, 30, 28]
        let barY: [CGFloat] = [botLevel - 15, botLevel - 50, botLevel - 80, botLevel - 50, botLevel - 15]
        let starY: [CGFloat] = [botLevel, botLevel, botLevel - 80, botLevel, botLevel]
        let visibles = [true, true, false, true, true]
        
        animateStages(startX: startX, stepX: step, heights: heights, barYs: barY, starYs: starY, visibles: visibles)
    }
    
    private func thirdStage() {
        let width: CGFloat = contentView.frame.width / 2
        let step: CGFloat = width / 4
        let startX: CGFloat = (contentView.frame.width - width) / 2
        let botLevel: CGFloat = contentView.frame.height - 187
        let heights: [CGFloat] = [18, 18, 50, 18, 18]
        let barY: [CGFloat] = [60, 40, 20, 40, 60]
        let starY: [CGFloat] = [botLevel - 45, botLevel - 60, botLevel - 70, botLevel - 60, botLevel - 45]
        let visibles = [false, false, false, false, false]
        
        animateStages(startX: startX, stepX: step, heights: heights, barYs: barY, starYs: starY, visibles: visibles)
    }
    
    private func animateStages(startX: CGFloat, stepX: CGFloat, heights: [CGFloat], barYs: [CGFloat], starYs: [CGFloat], visibles: [Bool]) {
        UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseInOut, animations: {
            for index in 0..<5 {
                let x: CGFloat = startX + CGFloat(index) * stepX
                let bar = self.currentShineViews[index]
                let star = self.currentStarViews[index]
                bar.alpha = visibles[index] ? 1 : 0
                star.alpha = visibles[index] ? 0 : 1
                
                bar.center = CGPoint(x: x, y: barYs[index])
                star.center = CGPoint(x: x, y: starYs[index])
                bar.bounds.size = CGSize(width: 4, height: heights[index])
                star.bounds.size = CGSize(width: heights[index], height: heights[index])
                star.size = heights[index]
            }
        }, completion: nil)
    }
}

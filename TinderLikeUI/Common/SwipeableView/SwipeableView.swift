//
//  SwipeablePersonView.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/26/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

protocol SwipeableViewDelegate: AnyObject {
    
    func didEndSwipe(onView view: SwipeableView)
}

class SwipeableView: UIView {
   
    weak var delegate: SwipeableViewDelegate?
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var gestureTranslation: CGPoint = .zero
    private var rotationAngle: CGFloat = CGFloat(Double.pi)/10.0
    private var swipePercentageMargin: CGFloat = 0.6
    private var maximumRotation: CGFloat = 1.0
    private var animationDirectionY: CGFloat = 1.0
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupGestureRecognizer()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupGestureRecognizer()
    }
    
    deinit {
        if let panGestureRecognizer = self.panGestureRecognizer {
            removeGestureRecognizer(panGestureRecognizer)
        }
    }
    
    private func setupGestureRecognizer() {
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panGestureRecognized(_:)))
        self.panGestureRecognizer = panGestureRecognizer
        addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc private func panGestureRecognized(_ sender: UIPanGestureRecognizer) {
        self.gestureTranslation = sender.translation(in: self)
        switch sender.state {
        case .began:
            layer.shouldRasterize = true
//            delegate?.didBeginSwipe(onView: self)
        case .changed:
            changedSwipe()
        case .ended:
            endedPanAnimation()
            layer.shouldRasterize = false
        default:
            resetPersonViewPosition()
            layer.shouldRasterize = false
        }
    }
    
    func resetPersonViewPosition() {
        UIView.animate(withDuration: 0.2) {
//            self.transform = CGAffineTransform.identity// reset transform
            self.layer.transform = CATransform3DIdentity
        }
    }
    
    func changedSwipe() {
        let rotationStrength = min(gestureTranslation.x / frame.width, maximumRotation)
        let rotationAngle = animationDirectionY * self.rotationAngle * rotationStrength
        var transform = CATransform3DIdentity
        transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1)
        transform = CATransform3DTranslate(transform, gestureTranslation.x, gestureTranslation.y, 0)
        layer.transform = transform
    }
    
    func endedPanAnimation() {
        let dragDirection = abs(gestureTranslation.x/center.x)
        if dragDirection > swipePercentageMargin {
            self.delegate?.didEndSwipe(onView: self)
            
        } else {
            resetPersonViewPosition()
        }
    }
}

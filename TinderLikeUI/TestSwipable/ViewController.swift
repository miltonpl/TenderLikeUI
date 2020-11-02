//
//  ViewController.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameLableView: UILabel!
    
    private var widthToDownScale: CGFloat!
    private var number: CGFloat = 1.0
    private var radians: CGFloat = 0.0
    private var centerX: CGFloat = 0.0
    private var viewModel = UsersDataSource()
    
    private var translation: CGPoint = .zero
    private var rotationAngle: CGFloat = CGFloat(Double.pi)/10.0
    private var swipePercentageMargin: CGFloat = 0.6
    private var maximumRotation: CGFloat = 1.0
    private var animationDirectionY: CGFloat = 1.0

    override func viewDidLoad() {
        super.viewDidLoad()
        //from center of screen
        self.widthToDownScale = self.view.frame.width/8
        centerX = self.view.center.x
        viewModel.fetchData("1")
        addInfo()
    }
    
    @IBAction func resetAction(_ sender: UIButton) {
        UIView.animate(withDuration: 0.2) {
            self.cardView.center = self.view.center
            self.cardView.alpha = 1
            self.cardView.transform = CGAffineTransform.identity// reset transform
            self.thumbImageView.alpha = 0
        }
    }
    
    @IBAction func panCard(_ sender: UIPanGestureRecognizer) {
        
        guard let cardView = sender.view else { return }
//        translation = sender.translation(in: cardView)
        self.translation = sender.translation(in: cardView)
        switch sender.state {
        case .began:
            print("began")
            
        case .changed:
            print("changed")
            
//            let rotationStrength = min(translation.x / cardView.frame.width, maximumRotation)
//            let rotationAngle = animationDirectionY * self.rotationAngle * rotationStrength
//            var transform = CATransform3DIdentity
//            transform = CATransform3DRotate(transform, rotationAngle, 0, 0, 1)
//            transform = CATransform3DTranslate(transform, translation.x, translation.y, 0)
//            cardView.layer.transform = transform
            changedSwipe()
            addThumbImage()

        case .ended:
            print("end")
            didEndSwipe(onView: cardView)
        case .failed, .possible, .cancelled:
            print(" .failed, .possible, .cancelled:")
        @unknown default: break
            
        }
    }
    
    private func addInfo() {
        titleLabel.text = "My name is"
        titleLabel.text = "Milton Palaguachi"
    }
    
    private func addThumbImage() {
        if centerX > 0 {
            number = 2.0
            thumbImageView.image = UIImage(named: "thumbup")
            thumbImageView.tintColor = UIColor.green
        } else {
            thumbImageView.image = UIImage(named: "thumbdown")
            thumbImageView.tintColor = UIColor.red
            number = -2.0
        }
        
        thumbImageView.alpha = abs(centerX*2)/view.center.x
        if cardView.center.y < self.view.center.y {
            cardView.center.y = self.view.center.y
        }
    }
    
    private func changedSwipe() {
        
        cardView.center = CGPoint(x: self.view.center.x + translation.x, y: self.view.center.y + translation.y)
        centerX = cardView.center.x - self.view.center.x
        let scale = min(abs(widthToDownScale/centerX), 1)
        radians = centerX/view.center.x
        cardView.transform = CGAffineTransform(rotationAngle: radians).scaledBy(x: scale, y: scale)
    }
    
    private func didEndSwipe(onView view: UIView) {
        let isFavorite = radians > swipePercentageMargin
        if abs(radians) >  swipePercentageMargin {
            UIView.animate(withDuration: 0.3) {
                print("remove")
                self.cardView.center = CGPoint(x: self.view.center.x * self.number, y: self.view.center.y*2)
                self.cardView.alpha = 0
//                view.removeFromSuperview()
            }
            if isFavorite {
                print("add to favorite list")
            }
            
        } else {
            UIView.animate(withDuration: 0.3) {
                print("back to center")
                self.cardView.center = self.view.center
                self.cardView.transform = CGAffineTransform.identity// reset transform
                self.thumbImageView.alpha = 0
                
            }
        }
    }
}

//
//  PersonView.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

protocol PersonViewDelegate: AnyObject {
    
    func didTap(view: PersonView)
    func didBeginSwipe(onView view: PersonView)
    func didEndSwipe(onView view: PersonView)
}

class PersonView: UIView {
   
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconsView: UIView!
   
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var callButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    weak var delegate: PersonViewDelegate?
    
    private var panGestureRecognizer: UIPanGestureRecognizer?
    private var translation: CGPoint = .zero
    private var rotationAngel: CGFloat = CGFloat(Double.pi)/10.0
    public var person: Person?
    
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
    
    @objc func panGestureRecognized(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            layer.shouldRasterize = true
        case .changed:
            var transform = CATransform3DIdentity
            transform = CATransform3DRotate(transform, rotationAngel, 0, 0, 1)
            transform = CATransform3DTranslate(transform, translation.x, translation.y, 0)
            layer.transform = transform
        case .ended:
            layer.shouldRasterize = false
        default:
            layer.shouldRasterize = false
        }
    }
    
    func configure() {
        guard let person = person else { return }
        print(person)
    }
    
}
extension PersonView {
    @IBAction func mapAction(_ sender: UIButton) {
          print("map")
      }
      
      @IBAction func lockAction(_ sender: UIButton) {
          print("lock")
      }
      
      @IBAction func calendarAction(_ sender: UIButton) {
          print("calendar")
      }
      
      @IBAction func profileAction(_ sender: UIButton) {
          print("profile")
      }
      
      @IBAction func callAction(_ sender: UIButton) {
          print("call")
      }
}
protocol NibView where Self: UIView {
    
}
extension NibView {
    func xibSetup (nibName: String) {
        backgroundColor = .clear
        let view = loadViewFrom(nibName: nibName)
        addEdgeConstrainedSubView(view: view)
    }
    //load a view form it's xib file
    private func loadViewFrom<T: UIView>(nibName: String) -> T {
        let nib = UINib(nibName: nibName, bundle: nil)
        guard let view = nib.instantiate(withOwner: nil, options: nil).first as? T else {
             fatalError("Cannot instantiate a UIView from PesonView Class: PersonView.xib")
        }
        return view
    }
}

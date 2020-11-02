//
//  CustomView.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/30/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

enum ViewType {
    case profile, calendar, lock, contact, map
}

class CustomView: SwipeableView, NibView {
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            self.backgroundView.layer.cornerRadius = 14.0
            self.backgroundView.layer.borderWidth = 1
            self.backgroundView.layer.borderColor = CGColor(srgbRed: 181.0/255.0, green: 191.0/255.0, blue: 203.0/255.0, alpha: 1.0)
        }
    }
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var iconsView: UIView!

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var infoButton: UIButton!
    @IBOutlet weak var unlockButton: UIButton!
    @IBOutlet weak var cantactButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    private var lastButton: UIButton?
    private var currentView: UIView?
    private var helper = Helper()
    weak var locationDelegate: MapViewDelegate?

    public var person: Person? {
        didSet {
            self.addProfileView()
            changeColdor(profileButton)
            lastButton = profileButton
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        xibSetup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func mapAction(_ sender: UIButton) {
        changeColdor(sender)
        setView(view: .map)
      }

      @IBAction func unlockAction(_ sender: UIButton) {
        changeColdor(sender)
        setView(view: .lock)
      }

      @IBAction func infoAction(_ sender: UIButton) {
        changeColdor(sender)
        setView(view: .calendar)
      }

      @IBAction func profileAction(_ sender: UIButton) {
        changeColdor(sender)
        setView(view: .profile)
      }

      @IBAction func contactAction(_ sender: UIButton) {
        changeColdor(sender)
        setView(view: .contact)
      }
    
    func changeColdor(_ currentButton: UIButton) {
        guard lastButton != currentButton else { return }
        lastButton?.imageView?.tintColor = CustomColor.blue
        currentButton.imageView?.tintColor = CustomColor.red
        lastButton = currentButton
    }
    
    func setView(view: ViewType) {
        switch view {
        case .profile:
            currentView?.removeFromSuperview()
            addProfileView()
        case .calendar:
            currentView?.removeFromSuperview()
            addInformationView()
        case .lock:
            currentView?.removeFromSuperview()
            addLockView()
        case .contact:
            currentView?.removeFromSuperview()
            addContactView()
        case .map:
            currentView?.removeFromSuperview()
            addMapView()
        }
    }
}

extension CustomView {
    
    func addProfileView() {
        let profileView = ProfileView()
        guard let name = person?.name, let firstName = name.first, let lastName = name.last, let strUrl = person?.picture?.largeUrl else { print("No first,last,url about the person"); return }
        profileView.configure(fullname: firstName + " " + lastName, strUrl: strUrl)
        self.containerView.addSubview(profileView)
        self.currentView = profileView
        self.addNSLayoutConstraint()
    }
    
    func addNSLayoutConstraint() {
        guard let currentView = self.currentView else { return }
        currentView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            currentView.topAnchor.constraint(equalTo: self.containerView.topAnchor),
            currentView.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor),
            currentView.leadingAnchor.constraint(equalTo: self.containerView.leadingAnchor),
            currentView.trailingAnchor.constraint(equalTo: self.containerView.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func addInformationView() {
        
        let calendarView = InformationView()
        guard let person = self.person, let date = person.dob?.date, let age = person.dob?.age, let gender = person.gender, let url = person.picture?.largeUrl else { return }
        let birthday = helper.convertDateFormatter(date: date)
        
        calendarView.configure(strUrl: url, birthday: birthday, age: "\(age)", gender: gender, interesteddIn: (gender == "male") ? "woman" : "man")
        
        self.containerView.addSubview(calendarView)
        self.currentView = calendarView
        self.addNSLayoutConstraint()
    }
    
    func addContactView() {
         
        let contact = Contact(cellPhone: person?.cell, homePhone: person?.phone, email: person?.email, url: person?.picture?.mediumUrl)
        let contactView = ContactView()
        
        contactView.configure(contact: contact)
        self.containerView.addSubview(contactView)
        self.currentView = contactView
        self.addNSLayoutConstraint()
    }
    
    func addLockView() {
        let lockView = UnlockView()
        lockView.configure()
        self.containerView.addSubview(lockView)
        self.currentView = lockView
        self.addNSLayoutConstraint()
    }
    
    func addMapView() {
        let mapView = MapView()
        mapView.locationDelegate = locationDelegate
        mapView.setUserLocation()
        self.containerView.addSubview(mapView)
        self.currentView = mapView
        self.addNSLayoutConstraint()
    }
}

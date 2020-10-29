//
//  PersonView.swift
//  TenderLikeUI
//
//  Created by Milton Palaguachi on 10/25/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
enum ViewType {
    case profile, calendar, lock, contact, map
}

class SwipeableCustomView: SwipeableUserViewCard {
   
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var iconsView: UIView!

    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var calendarButton: UIButton!
    @IBOutlet weak var lockButton: UIButton!
    @IBOutlet weak var cantactButton: UIButton!
    @IBOutlet weak var mapButton: UIButton!
    
    private var lastButton: UIButton?
    private var currentView: UIView?
    private var helper = Helper()

    public var person: Person? {
        didSet {
            self.configure()
            self.addProfileView()
            changeColdor(profileButton)
            lastButton = profileButton
        }
    }
    
    func configure() {
        print("configure")
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func mapAction(_ sender: UIButton) {
        changeColdor(sender)
        setView(view: .map)
      }

      @IBAction func lockAction(_ sender: UIButton) {
        changeColdor(sender)
        setView(view: .lock)
      }

      @IBAction func calendarAction(_ sender: UIButton) {
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
        lastButton?.imageView?.tintColor = .systemBlue
        currentButton.imageView?.tintColor = .red
        lastButton = currentButton
    }
    
    func setView(view: ViewType) {
        switch view {
        case .profile:
            currentView?.removeFromSuperview()
            print("profile")
            addProfileView()
        case .calendar:
            print("calendar")
            currentView?.removeFromSuperview()
            addCalendarView()
        case .lock:
            print("lock")
            currentView?.removeFromSuperview()
            addLockView()
        case .contact:
            print("phone")
            currentView?.removeFromSuperview()
            addContactView()
        case .map:
            print("map")
        }
    }
}

extension SwipeableCustomView {
    
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
    
    func addCalendarView() {
        
        let calendarView = CalendarView()
        guard let person = self.person, let date = person.dob?.date, let age = person.dob?.age, let gender = person.gender, let url = person.picture?.largeUrl else { return }
        let birthday = helper.convertDateFormatter(date: date)
        calendarView.configure(strUrl: url, birthday: birthday, age: "\(age)", gender: gender, interesteddIn: "All")
        
        self.containerView.addSubview(calendarView)
        self.currentView = calendarView
        self.addNSLayoutConstraint()
    }
    
    func addContactView() {
        let contactView = ContactView()
        self.containerView.addSubview(contactView)
        self.currentView = contactView
        self.addNSLayoutConstraint()
    }
    
    func addLockView() {
        let lockView = LockView()
        lockView.configure()
        self.containerView.addSubview(lockView)
        self.currentView = lockView
        self.addNSLayoutConstraint()
    }
    
    func makeACall() {
        guard let strPhone = person?.phone else { return }
        let number = strPhone.components(separatedBy: CharacterSet.decimalDigits.inverted)
            .joined()
        print(number)
        
        if let url = URL(string: "tel://\(number)"),
            UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        } else {
            print("Did Not work")
        }
    }
}

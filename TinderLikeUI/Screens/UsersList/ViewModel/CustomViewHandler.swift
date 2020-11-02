//
//  CustomViewHandler.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/30/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
enum OffSet: Int {
    case zero = 0
    case one = 1
    case two = 2
}
protocol CustomViewHandlerDelegate: AnyObject {
    func userInQueue(frontUser: UserInfo)
}

class CustomViewHandler: UIView {
    weak var delegate: CustomViewHandlerDelegate?
    private var userViews: [CustomView] = []
    
    private let horizontalInset: CGFloat = 7.0
    private let verticalInset: CGFloat = 7.0
    private let numberOfVisibleUsers: Int = 3
    private var remaindingUsers: Int = 0
    
    var dataSourceProtocol: DataSouceProtocol? {
        didSet {
            reloadData()
        }
    }
    
    private var visibleUserViews: [CustomView] {
        return subviews as? [CustomView] ?? []
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = .clear
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func reloadData() {
        
        self.removeUserViews()
        guard let dataSource = self.dataSourceProtocol else { return }
        
        self.remaindingUsers = dataSource.numberOfUsers()
        
        for index in 0..<min(remaindingUsers, numberOfVisibleUsers) {
            addUserView(userView: dataSource.getUserView(at: index), atIndex: index)
        }
        self.setFrontUser()
        if let emptyView = dataSource.viewForNoUser() {
            addEdgeConstrainedSubView(view: emptyView)
        }
        setNeedsLayout()
    }
    
    func setFrontUser() {
        guard let lastView = self.subviews.last as? CustomView, let name = lastView.person?.name else { return }
        let frontUser = UserInfo(imageUrl: lastView.person?.picture?.mediumUrl ?? "", title: name.first ?? "", subtitle: name.last ?? "")
        delegate?.userInQueue(frontUser: frontUser)
    }
    
    private func removeUserViews() {
        for userView in visibleUserViews {
            userView.removeFromSuperview()
        }
        self.userViews = []
    }
    private func addUserView(userView: CustomView, atIndex index: Int) {
        userView.delegate = self
        
        self.setFrame(forUserView: userView, by: index)
        self.userViews.append(userView)
        insertSubview(userView, at: 0)
        self.remaindingUsers -= 1
    }
    
    private func setFrame(forUserView userView: CustomView, by moveFrame: Int) {
        var userViewBound = bounds
        let horizontalInset = CGFloat(moveFrame) * self.horizontalInset
        let verticalInset = CGFloat(moveFrame) * self.verticalInset
        userViewBound.size.width -= 2 * horizontalInset
        userViewBound.origin.x += horizontalInset
        userViewBound.origin.y += verticalInset
        userView.frame = userViewBound
    }
    
    func userToDequeue() {
        if let userView = self.subviews.last as? SwipeableView {
            didEndSwipe(onView: userView)
        }
    }
}

extension CustomViewHandler: SwipeableViewDelegate {
    
    func didEndSwipe(onView view: SwipeableView) {

        guard let dataSource = self.dataSourceProtocol else { return }
        view.removeFromSuperview()
        self.setFrontUser()
        if remaindingUsers > 0 {
            let newIndex = dataSource.numberOfUsers() - self.remaindingUsers
            addUserView(userView: dataSource.getUserView(at: newIndex), atIndex: 2)
            for (index, userView) in visibleUserViews.reversed().enumerated() {
                UIView.animate(withDuration: 0.3) {
                    userView.center = self.center
                    self.setFrame(forUserView: userView, by: index)
                    self.layoutIfNeeded()
                }
            }
        }
    }
}

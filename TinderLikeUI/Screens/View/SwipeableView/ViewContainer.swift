//
//  SwipeableUserContatainer.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/26/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
protocol SwipeableUserViewDelegate: AnyObject {
    func didSelect(user: SwipeableUserViewCard, atIndex index: Int)
}

class ViewContainer: UIView {
    
    private let horizontalInset: CGFloat = 10.0
    private let verticalInset: CGFloat = 10.0
    private let numberOfVisibleUsers: Int = 3
    private var remaindingUsers: Int = 0
    
    weak var delegate: SwipeableUserViewDelegate?
    private var userViews: [SwipeableUserViewCard] = []
    var dataSourceProtocol: UserViewDataSourceProtocol? {
        didSet {
            reloadData()
        }
    }
    
    private var visibleUserViews: [SwipeableUserViewCard] {
        return subviews as? [SwipeableUserViewCard] ?? []
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
        
        if let emptyView = dataSource.viewForNoUser() {
            addEdgeConstrainedSubView(view: emptyView)
        }
        setNeedsLayout()
    }
    
    private func removeUserViews() {
        for userView in visibleUserViews {
            userView.removeFromSuperview()
        }
        self.userViews = []
    }
    private func addUserView(userView: SwipeableUserViewCard, atIndex index: Int) {
        userView.delegate = self
        
        self.setFrame(forUserView: userView, by: index)
        self.userViews.append(userView)
        insertSubview(userView, at: 0)
        self.remaindingUsers -= 1
    }
    
    private func setFrame(forUserView userView: SwipeableUserViewCard, by moveFrame: Int) {
        var userViewBound = bounds
        print(bounds)

        let horizontalInset = CGFloat(moveFrame) * self.horizontalInset
        let verticalInset = CGFloat(moveFrame) * self.verticalInset
        
        userViewBound.size.width -= 2 * horizontalInset
        userViewBound.origin.x += horizontalInset
        userViewBound.origin.y += verticalInset
        print(bounds)
        userView.frame = userViewBound
        print(userView.frame)
    }
}

extension ViewContainer: SwipeableViewDelegate {
    
    func didTap(view: SwipeableView) {
        if let userView = view as? SwipeableUserViewCard,
            let index = self.userViews.lastIndex(of: userView) {
            delegate?.didSelect(user: userView, atIndex: index)
        }
    }
    
    func didEndSwipe(onView view: SwipeableView) {
        print("didEndSwipe")
        guard let dataSource = self.dataSourceProtocol else { return }
        view.removeFromSuperview()
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

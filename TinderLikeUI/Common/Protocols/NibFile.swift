//
//  NibFile.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/26/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit

/// A base UIView subclass that instaniates a view
/// from a nib file of the same class name in order to
/// allow reusable views to be created.
internal protocol NibView where Self: UIView {

}

extension NibView {

    func xibSetup() {
        backgroundColor = .clear
        let view = loadViewFromNib()
        addEdgeConstrainedSubView(view: view)
    }
    /// - Returns: an instantiated view from the Nib file of the same class name.
    fileprivate func loadViewFromNib<T: UIView>() -> T {
        let bundle = Bundle(for: type(of: self))
        print("In loadViw: ", String(describing: type(of: self)))
        
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        guard let view = nib.instantiate(withOwner: self, options: nil).first as? T else {
            fatalError("Cannot instantiate a UIView from the nib for class \(type(of: self))")
        }
        print("succeed")
        return view
    }
    
}

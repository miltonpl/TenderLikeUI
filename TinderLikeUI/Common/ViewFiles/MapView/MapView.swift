//
//  MapView.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/27/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import UIKit
import MapKit

protocol MapViewDelegate: AnyObject {
    func getUserLocation() -> CLLocation?
}

class MapView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    private var boundingRegion: MKCoordinateRegion = MKCoordinateRegion(MKMapRect.world)
    weak var locationDelegate: MapViewDelegate?
    @IBOutlet weak var mapView: MKMapView! {
        didSet {
            self.mapView.delegate = self
            self.mapView.showsUserLocation = true
            self.mapView.showsCompass = true
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initSubviews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.initSubviews()
    }
    func setUserLocation() {
        if let location = locationDelegate?.getUserLocation() {
            self.mapView.centerToLocation(location)
        }
    }
    
    func initSubviews() {
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: nil)
        nib.instantiate(withOwner: self, options: nil)
        addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        let constraints = [
            contentView.topAnchor.constraint(equalTo: self.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            contentView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MapView: MKMapViewDelegate {
    
}

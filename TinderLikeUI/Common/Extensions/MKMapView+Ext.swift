//
//  MKMapView+Ext.swift
//  TinderLikeUI
//
//  Created by Milton Palaguachi on 10/29/20.
//  Copyright © 2020 Milton. All rights reserved.
//

import MapKit

extension MKMapView {
    func centerToLocation(_ location: CLLocation, regionRadius: CLLocationDistance = 1000) {
        let coordinateRegion = MKCoordinateRegion(
            center: location.coordinate,
            latitudinalMeters: regionRadius,
            longitudinalMeters: regionRadius)
        setRegion(coordinateRegion, animated: true)
    }
}

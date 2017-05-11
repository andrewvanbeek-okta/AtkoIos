//
//  PlaceAnnotationswift.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/25/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import MapKit

class PlaceAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    
    init(location: CLLocationCoordinate2D, title: String) {
        self.coordinate = location
        self.title = title
        
        super.init()
    }
}

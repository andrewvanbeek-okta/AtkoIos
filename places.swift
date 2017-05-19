//
//  places.swift
//  Mobile-Sign
//
//



import Foundation
import CoreLocation

class Place: ARAnnotation {
    var thing: String?
    
    init(location: CLLocation, title: String) {
        
        
        super.init()
        self.thing = title
        self.location = location
    }
    
}

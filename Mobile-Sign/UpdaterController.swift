//
//  UpdaterController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/26/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation
import AppAuth
import CoreLocation

class UpdaterControlelr: CommonViewController, CLLocationManagerDelegate {
    let manager = CLLocationManager()
    var location = CLLocation()
    


    @IBAction func updateLocation(_ sender: Any) {
        manager.startUpdatingLocation()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
               // Creates a marker in the center of the map.

        let urla = "https://dev-885515.oktapreview.com/api/v1/users/\(userId)"
        let header: [String : String] = ["Authorization" : appConfig.token as String!]
        let sendLat = location.coordinate.latitude
        let sendLon = location.coordinate.longitude
        let profile = ["profile": ["LoginLat": sendLat, "LoginLon": sendLon]]
        
        Alamofire.request(urla, method: .post, parameters: profile, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
            guard response.result.error == nil else {
                return
            }
        }
        
        manager.stopUpdatingLocation()
    }

}

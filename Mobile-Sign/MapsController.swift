//
//  MapsController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/22/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire
import AppAuth


class MapsController: CommonViewController, CLLocationManagerDelegate {
   let manager = CLLocationManager()
    var location = CLLocation()
    

    @IBOutlet weak var navView: UIView!
    
    @IBAction func HomeBack(_ sender: UIButton) {
        print("hey")
        performSegue(withIdentifier: "backToMain", sender: nil)
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations[0]
        let camera = GMSCameraPosition.camera(withLatitude: location.coordinate.latitude,
                                              longitude: location.coordinate.longitude,
                                              zoom: 3)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        marker.title = "You"
        marker.snippet = "Now"
        marker.map = mapView
//        let urla = "https://dev-885515.oktapreview.com/api/v1/users/00ua37ke0cpMWtaVr0h7"
        let header: [String : String] = ["Authorization" : "SSWS 0062IiqfTB-b2MwADd5l7XEJLrQXJHl0CW079NrdUg"]
//        let sendLat = location.coordinate.latitude 
//        let sendLon = location.coordinate.longitude 
//        let profile = ["profile": ["LoginLat": sendLat, "LoginLon": sendLon]]
//        
//        Alamofire.request(urla, method: .post, parameters: profile, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
//            guard response.result.error == nil else {
//                return
//            }
//        }
        
        manager.stopUpdatingLocation()
        
          let url = "https://dev-885515.oktapreview.com/api/v1/logs?q=Andrew"
            Alamofire.request(url, headers: header).responseJSON{ response in
                guard response.result.error == nil else {
                    print("turn up")
                    print(response)
                    return
                }
                    guard response.result.error != nil else {
                        print("turn up")
                        let allResponses = response.result.value as! NSArray
                        print("break")
                        for i in 0 ..< allResponses.count  {
                            print("hey")
                   
                   
                            let response = allResponses[i] as! NSDictionary
                            let client = response["client"] as! NSDictionary
                        if(client["geographicalContext"] != nil){
                            print(response)
                            var device = String()
                            if(client["device"] != nil){
                                device = client["device"] as! String
                            }
                            let time = response["published"] as! String
                            let geoContext = client["geographicalContext"] as! NSDictionary
                            if(geoContext["geolocation"] != nil){
                                print(geoContext)
                                let geoLocation = geoContext["geolocation"] as! NSDictionary
                                if(geoLocation["lat"] != nil){
                                    _ = NumberFormatter()
                                    let latitude = geoLocation["lat"] as! Float
                                    let longitude = geoLocation["lon"] as! Float
                                    let mark = GMSMarker()
                                    mark.position = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitude))
                                    mark.snippet = time
                                    mark.title = device
                                    mark.map = mapView
                                }
                            }
                        }
                    }
                    print("break")
                    return
                }
                let button = UIButton(frame: CGRect.zero)
                button.setTitle("checky", for: .normal)
                self.view.addSubview(button)
            }
        

    }
    
    override func viewDidLoad() {

        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.requestWhenInUseAuthorization()
        manager.startUpdatingLocation()
        
    }

}

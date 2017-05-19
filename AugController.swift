//
//  AugController.swift
//  
//
//  Created by Andrew Van Beek on 4/25/17.
//
//

import Foundation
import UIKit
import AVFoundation
import CoreLocation
import MapKit
import Alamofire

class AugController: UIViewController, CLLocationManagerDelegate {
    fileprivate var arViewController: ARViewController!
    
    @IBAction func check(_ sender: Any) {
        arViewController = ARViewController()
        //1
        arViewController.dataSource = self
        //2
        arViewController.maxVisibleAnnotations = 30
        arViewController.headingSmoothingFactor = 0.1
        //3
        arViewController.setAnnotations(places)
        
        self.present(arViewController, animated: true, completion: nil)
        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 400, height: 50))
       arViewController.view.addSubview(navBar);
        let navItem = UINavigationItem(title: "");
        let backButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(AugController.goBack))
        navItem.leftBarButtonItem = backButton
        navBar.barTintColor = UIColor.black
        navBar.backgroundColor = UIColor.black
        
        //Change navigation title, backbutton colour
        
       
        navBar.setItems([navItem], animated: false);
        navBar.barTintColor = UIColor.black
        navBar.backgroundColor = UIColor.black
    }
    func goBack() {
        arViewController.dismiss(animated: true, completion: {});
//        let secondViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondview") as UIViewController
//        self.present(secondViewController, animated: false, completion: nil)
//        performSegue(withIdentifier: "arsegue", sender: nil)
    
    }
    
    func this(){
        var homeController = SecondViewController()
         self.present(homeController, animated: true, completion: nil)
    }
   

    @IBOutlet weak var mapVIew: MKMapView!
    
    fileprivate let locationManager = CLLocationManager()
    fileprivate var startedLoadingPOIs = false
    fileprivate var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.requestWhenInUseAuthorization()

        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //1
        if locations.count > 0 {
            let location = locations.last!
            print("Accuracy: \(location.horizontalAccuracy)")
            
            //2
            
                //3
                manager.stopUpdatingLocation()
                 self.mapVIew.showsUserLocation = true;
                let span = MKCoordinateSpan(latitudeDelta: 0.014, longitudeDelta: 0.014)
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                mapVIew.region = region
                var url = "\(appConfig.kIssuer as String)/api/v1/users"
                if(token != nil){
                    let header: [String : String] = ["Authorization" : appConfig.token as String!]
                    Alamofire.request(url, headers: header).responseJSON{ response in
                        var tableInfoToBeInserted = [String]()
                        guard response.result.error != nil else {
                            
                            // got an error in getting the data, need to handle it
                            let json = response.result.value as! NSArray
                            for i in 0 ..< json.count  {
                                let userInfoBlob = json[i] as! NSDictionary
                                let profile = userInfoBlob["profile"] as! NSDictionary
                                print(profile)
                                let firstName = profile["firstName"] as! String
                                let lastName = profile["lastName"] as! String
                                let name = "\(firstName) \(lastName)"
                                let email = profile["email"] as! String
                                let userString = "Name: \(name.capitalized), \n Email: \(email.capitalized)"
                                tableInfoToBeInserted.append(userString)
                                if(profile["LoginLat"] != nil){
                                var lat = profile["LoginLat"] as! Double
                                var lon = profile["LoginLon"] as! Double
                                let spot = CLLocationCoordinate2D(latitude: CLLocationDegrees(lat), longitude: CLLocationDegrees(lon))
                                    var placer: CLLocation =  CLLocation(latitude: spot.latitude, longitude: spot.longitude)

                                let place = Place(location: placer, title: name)
                                self.places.append(place)
                                let annotation = PlaceAnnotation(location: spot, title: "HEY")
                                self.mapVIew.addAnnotation(annotation)
                                }

                            }
                        
                        return
                        }
                        
                    }
                }

             
            }
        
    }

}
extension AugController: AnnotationViewDelegate {
    func didTouch(annotationView: AnnotationView) {
        //1
        if let annotation = annotationView.annotation as? Place {
         }
    }
}

extension AugController: ARDataSource {
    func ar(_ arViewController: ARViewController, viewForAnnotation: ARAnnotation) -> ARAnnotationView {
        let annotationView = AnnotationView()
        annotationView.annotation = viewForAnnotation
        annotationView.delegate = self
        annotationView.frame = CGRect(x: 0, y: 15, width: 150, height: 500)
        
        return annotationView
    }
}

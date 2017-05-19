//
//  PlacesLoader.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 5/19/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import CoreLocation

struct PlacesLoader {
    let apiURL = "https://maps.googleapis.com/maps/api/place/"
    let apiKey = "" //go to google to generate a google maps key
    
    func loadPOIS(location: CLLocation, radius: Int = 30, handler: @escaping (NSDictionary?, NSError?) -> Void) {
        print("Load pois")
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude
        
        let uri = apiURL + "nearbysearch/json?location=\(latitude),\(longitude)&radius=\(radius)&sensor=true&types=establishment&key=\(apiKey)"
        
        let url = URL(string: uri)!
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let dataTask = session.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            } else if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    print(data!)
                    
                    do {
                        let responseObject = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                        guard let responseDict = responseObject as? NSDictionary else {
                            return
                        }
                        
                        handler(responseDict, nil)
                        
                    } catch let error as NSError {
                        handler(nil, error)
                    }
                }
            }
        }
        
        dataTask.resume()
    }
    
    
}

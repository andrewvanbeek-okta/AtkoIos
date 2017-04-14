//
//  commonviewcontroller.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/12/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AVFoundation  


class CommonViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        var timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(CommonViewController.checker), userInfo: nil, repeats: true)
        
    }
    
    func checker (){
        if(cookie != ""){
            print("cheeky boi")
            var header = ["Authorization" : "SSWS 00QRhOZHw3eQm6VK-Ma_NqNbu7uhzN4bc3OeF7l-SG"]
            var validSessionUrl = "https://vanbeektech.okta.com/api/v1/sessions/" + cookie
            Alamofire.request(validSessionUrl, headers: header)
                .responseJSON { response in
                    
                    guard response.result.error != nil else {
                        // got an error in getting the data, need to handle it
                        print("Got a valid session, this is the right checker")
                        print(response.result.value)
                        if let result = response.result.value {
                            let JSON = result as! NSDictionary
                            var cookieStatus = JSON["status"] as! String
                            if(cookieStatus == "ACTIVE"){
                                print("the user is still signed in")
                                
                            } else {
                            
                                                            }
                            
                            
                        }
                        return
                    }
                    
            }

        } else {
            
            print("whacky tacky")
        }
        
        
    }
}


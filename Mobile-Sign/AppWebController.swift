//
//  AppWebController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/22/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import AppAuth

class AppWebControler: CommonViewController{

    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var session = (authState?.lastTokenResponse?.idToken)! as String
        var url = "https://dev-885515.oktapreview.com/api/v1/sessions/\(userId)"
        var header : [String : String] = ["Cookie" : "\(session)"]
        Alamofire.request(url, headers: header).responseJSON{ response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                print("ok")
                print(response)
                return
            }
            guard response.result.error != nil else {
                // got an error in getting the data, need to handle it
                print("ok")
                print(response)
                return
            }
        }

        
        
//        let url = URL(string:"https://dev-885515.oktapreview.com")
//        myWebView.loadRequest(URLRequest(url: url!))
//        
    }

}

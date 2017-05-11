//
//  SecondViewController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/11/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import UIKit
import AppAuth
import Alamofire


class SecondViewController: CommonViewController {



    
    /**  Required method  */

    var readyIndicator = UIActivityIndicatorView()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            print("TURN UP TURN UP")
        self.loadState()
        print(authState as Any)
        // Do any additional setup after loading the view, typically from a nib.
        let url = "\(appConfig.kIssuer as String)/oauth2/v1/userinfo"
        let token = (authState?.lastTokenResponse?.accessToken)! as String
        print(token)
        print(url)
//        if(token != nil){
            let header : [String : String] = ["Authorization" : "Bearer \(token)"]
        Alamofire.request(url, headers: header).responseJSON{ response in
            guard response.result.error == nil else {
                // got an error in getting the data, need to handle it
                            return
            }
            
            guard response.result.error != nil else {
                // got an error in getting the data, need to handle it
                let JSON = response.result.value as! NSDictionary
                print(JSON)
                print(JSON["given_name"] as Any)
                if (JSON["given_name"] != nil){
                    print("gets here")
                    userId = JSON["sub"] as! String
                    let personFirstName = JSON["given_name"] as! String
                     //var personLastName = JSON["family_name"] as! String
                    self.userPerson.setTitle("Welcome \(personFirstName.capitalized)", for: .normal)
                }

                return
            }
            // make sure we got some JSON since that's what we expect
      

        }
//        }
        Alamofire.request("https://dev-885515.oktapreview.com/oauth2/ausaeb2svnW54G3RT0h7", headers: header).responseJSON{ response in
            guard response.result.error != nil else {
                print(response)
                return
            }
            guard response.result.error == nil else {
                print(response)
                return
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogginOut(_ sender: UIButton) {
        logThemOut()
    }
  
    @IBOutlet weak var userPerson: UIButton!
    func logThemOut() {
        
        print("TEEEEEEST")
        let gotoplace: String = "\(appConfig.kIssuer as String)/api/v1/users/\(userId)/sessions"
        let header: [String : String] = ["Authorization" : appConfig.token as! String]
        

        Alamofire.request(gotoplace, method: .delete, parameters: ["user": ""], encoding: JSONEncoding.default, headers: header).responseJSON{ response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /lists")
                    print(response.result.error!)
                    return
                }
                
                guard response.result.error != nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /lists")
                    print(response)
                    return
                }
                // make sure we got some JSON since that's what we expect
     
          
              self.performSegue(withIdentifier: "killSession", sender: nil)
        }
        
        
               }
   
    
}

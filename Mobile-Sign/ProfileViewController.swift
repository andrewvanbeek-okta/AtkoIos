//
//  ProfileViewController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/19/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import UIKit
import AppAuth
import Alamofire

class ProfileViewController: CommonViewController {

    @IBOutlet weak var profileTitle: UILabel!

    @IBOutlet weak var profileInformation: UITextView!
    
    @IBAction func backhome(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "profileToHome", sender: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = "\(appConfig.kIssuer as String)/oauth2/v1/userinfo"
        let token = (authState?.lastTokenResponse?.accessToken)! as String
        print(token)
        print(url)
  
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
                        print("does these exisit")
                       let personFirstName = JSON["given_name"] as! String
                        let personLastName = JSON["family_name"] as! String
                        let personEmail = JSON["email"] as! String
                        let locale = JSON["locale"] as! String
                        let region = JSON["zoneinfo"] as! String
                        let personUserName = JSON["preferred_username"] as! String
                        self.profileTitle.text = "\(personFirstName.capitalized) \(personLastName.capitalized)"
                        self.profileInformation.text = "Email: \(personEmail.capitalized) \n Username: \(personUserName.capitalized) \n Locale: \(locale.capitalized) \n Region: \(region.capitalized)"
                    }
                    
                    return
                }
        
                
            }
        
    }


}

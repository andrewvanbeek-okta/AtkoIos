//
//  RegisterController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/13/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation
import UIKit
import Alamofire


class RegisterController : CommonViewController {

    @IBAction func register(_ sender: Any) {
        register(firstname: firstname.text!, lastname: lastname.text!, email: email.text!, password: password.text!)
    }
    @IBOutlet weak var errorMsg: UILabel!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cookie)
        
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }

    func register(firstname: String, lastname: String, email: String, password: String){
        if(!firstname.isEmpty && !lastname.isEmpty && !email.isEmpty && !password.isEmpty){
        print("test")
            if(validateEmail(candidate: email) == true){
                var url = "\(appConfig.kIssuer as String)/api/v1/users?activate=true"
                let header: [String : String] = ["Authorization" : appConfig.token as String!]
                let profile = ["profile": ["firstName": firstname, "lastName": lastname, "login": email, "email": email ], "credentials": ["password" : ["value": password]]] as [String : Any]
                Alamofire.request(url, method: .post, parameters: profile, encoding: JSONEncoding.default, headers: header).responseJSON{ response in
                    guard response.result.error == nil else {
                        print(response)
              
                  
                        return
                    }
                    guard response.result.error != nil else {
                        print(response)
                        let response = response.result.value as! NSDictionary
                        let status =  response["status"] as! String
                        if (status == "ACTIVE"){
                            self.errorMsg.textColor = UIColor.green
                            self.errorMsg.text = "User created, check email"
                        
                        }
                        return
                    }
                }

                
            } else {
                errorMsg.text = "Improper Email"
                errorMsg.textColor = UIColor.red
            }
            
        } else {
            errorMsg.text = "Fill out fields with proper email."
            errorMsg.textColor = UIColor.red
            errorMsg.center = self.view.center
        
        }
    
    }
}

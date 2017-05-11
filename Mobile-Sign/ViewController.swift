//
//  ViewController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/11/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import UIKit
import Alamofire
import AVFoundation
import AppAuth
import WebKit
import SafariServices


var cookie : String = String()
var token : String = String()
var status : String = String()
var sessToken : String = String()



class ViewController: CommonViewController {

    let safariVC = SecondViewController()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        let issuer = URL(string: appConfig.kIssuer)
        
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer!) {
            config, error in
            
            if ((config == nil)) {
                print("Error retrieving discovery document: \(error?.localizedDescription)")
                return
            }
            //config document on the endpoints
            print("Retrieved configuration: \(config!)")
        }
        
        var reqParams = ["username": "andrew.vanbeek",
                         "password": "Vanawsome8839!!"]
        
        print("CHECK THIS DUDE")
        
        

     
                 // make sure we got some JSON since that's what we expect
        
        
            //self.performSegue(withIdentifier: "killSession", sender: nil)
        
        
        
        
        


        self.loadState()
            return
    }
    
  



    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    

  
    

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Signin(_ sender: UIButton) {
        authenticate()
        
    }
    
    func authenticate() {
        let issuer = URL(string: appConfig.kIssuer)
        let redirectURI = URL(string: appConfig.kRedirectURI)
        
        // Discovers Endpoints
 
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer!) {
            config, error in
            
            if ((config == nil)) {
                print("Error retrieving discovery document: \(error?.localizedDescription)")
                return
            }
            //config document on the endpoints
            print("Retrieved configuration: \(config!)")

            
            // Build Authentication Request
            
            
            let request = OIDAuthorizationRequest(configuration: config!,
                                                  clientId: appConfig.kClientID,
                                                  scopes: [
                                                    OIDScopeOpenID,
                                                    OIDScopeProfile,
                                                    OIDScopeEmail,
                                                    OIDScopePhone,
                                                    OIDScopeAddress,
                                                    "groups",
                                                    "offline_access"
                ],
                                                  redirectURL: redirectURI!,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)
          
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            
            
            print("Initiating Authorization Request: \(request)")
            appDelegate.currentAuthorizationFlow =
                OIDAuthState.authState(byPresenting: request, presenting: self){
                    authorizationResponse, error in
                    if(authorizationResponse != nil) {
                        self.setAuthState(authorizationResponse)
                        let authToken = authorizationResponse!.lastTokenResponse!.accessToken!
                        let refreshToken = authorizationResponse!.lastTokenResponse!.refreshToken!
                        let idToken = authorizationResponse!.lastTokenResponse!.idToken!
                        print("Retrieved Tokens.\n\nAccess Token: \(authToken) \n\nRefresh Token: \(refreshToken) \n\nId Token: \(idToken)")
                        self.performSegue(withIdentifier: "authing", sender: nil)
                        
                    } else {
                        print("Authorization Error: \(error!.localizedDescription)")
                        self.setAuthState(nil)
                    }
            }
        }

        
            


//            var gotoplace = "https://your-subdomain.okta.com/oauth2/v1/authorize?client_id={clientId}&response_type=id_token&scope=openid&prompt=none&redirect_uri=https%3A%2F%2Fyour-app.example.com&state=Af0ifjslDkj&nonce=n-0S6_WzA2Mj&sessionToken=0HsohZYpJgMSHwmL9TQy7RRzuY"
       
        
        
     }


}


//
//  models.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/13/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation

import Foundation

class OktaConfiguration {
    let kIssuer: String!
    let kClientID: String!
    let kRedirectURI: String!
    let kAppAuthExampleAuthStateKey: String!
    let apiEndpoint: URL!
    let token: String!

    
    init(){
        kIssuer = "https://dev-885515.oktapreview.com"                        // Base url of Okta Developer domain
        kClientID = "4dRnXNXSfPKMumPRgHqS"                                  // Client ID of Application
        apiEndpoint = URL(string: "https://dev-885515.oktapreview.com")         // Resource Server URL
        kRedirectURI = "com.oktapreview.dev885515:/openid"
        kAppAuthExampleAuthStateKey = "com.okta.openid.authState"
               token = "SSWS 0062IiqfTB-b2MwADd5l7XEJLrQXJHl0CW079NrdUg" //Keep the SWSS before the API key like SWSS XXXXXXXXXXXXXXX
     
    }
    
    
}

// Helpful to have overview:  How do you integrate with mobile--- openId AppAuth authorization flow
// challenge question is to integrate auth with mobile native, AppAuth authorization responses setting NSurl Default Session
// Are you browser based or mobile

//
//  models.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/13/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//



import Foundation

class OktaConfiguration {
    let kIssuer: String!
    let kClientID: String!
    let kRedirectURI: String!
    let kAppAuthExampleAuthStateKey: String!
    let apiEndpoint: URL!
    let token: String!
    
    
    init(){
        kIssuer = "replace with okta url"                        // Base url of Okta Developer domain
        kClientID = " replace with client id from Okta open id app"                                  // Client ID of Application
        apiEndpoint = URL(string: "replace with okta url")         // Resource Server URL
        kRedirectURI = " replace with redirect uri" //redirect URI fro
        kAppAuthExampleAuthStateKey = "com.okta.openid.authState"
        token = "SSWS (keep the SWSS part) but add api token value" //Keep the SWSS before the API key like SWSS XXXXXXXXXXXXXXX
        
    }
    
    
}

// Helpful to have overview:  How do you integrate with mobile--- openId AppAuth authorization flow
// challenge question is to integrate auth with mobile native, AppAuth authorization responses setting NSurl Default Session
// Are you browser based or mobile

// Helpful to have overview:  How do you integrate with mobile--- openId AppAuth authorization flow
// challenge question is to integrate auth with mobile native, AppAuth authorization responses setting NSurl Default Session
// Are you browser based or mobile

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

var cookie : String = String()
var token : String = String()
var status : String = String()


class ViewController: CommonViewController {
    

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        print(cookie)
        let path = Bundle.main.path(forResource: "newyork", ofType: "mp4")
        var player = AVPlayer(url: NSURL(fileURLWithPath: path!) as URL)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.zPosition = -1
        playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.view.layer.addSublayer(playerLayer)
        player.seek(to: kCMTimeZero);
        player.play()
        func loopVideo(videoPlayer: AVPlayer) {
            NotificationCenter.default.addObserver(forName: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil, queue: nil) { notification in
                videoPlayer.seek(to: kCMTimeZero)
                videoPlayer.play()
            }
        }
        loopVideo(videoPlayer: player)
    }
    
 

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Signin(_ sender: UIButton) {
        print("TEEEEEEST")
        let gotoplace: String = "https://vanbeektech.okta.com/api/v1/authn"

        let user: [String: Any] = ["username": username.text, "password": password.text];        print(user)
        Alamofire.request(gotoplace, method: .post, parameters: user, encoding: JSONEncoding.default)
            .responseJSON { response in
                
                guard response.result.error == nil else {
                    // got an error in getting the data, need to handle it
                    return
                }
                
                guard response.result.error != nil else {
                    // got an error in getting the data, need to handle it
                    print("error calling POST on /lists")
                    print(response.result.value)
                    if let result = response.result.value {
                        let JSON = result as! NSDictionary
                        print(JSON)
                        print(token)
                        if((JSON["sessionToken"]) != nil){

                            token = JSON["sessionToken"] as! String

            
                        var sessionUrl = "https://vanbeektech.okta.com/api/v1/sessions"
                        var sessionToken = ["sessionToken" : token]
                        Alamofire.request(sessionUrl, method: .post, parameters: sessionToken, encoding: JSONEncoding.default)
                            .responseJSON { response in
                                
                                guard response.result.error != nil else {
                                    // got an error in getting the data, need to handle it
                                    if let result = response.result.value {
                                        let JSON = result as! NSDictionary
                                        print(JSON)
                                        cookie = JSON["id"] as! String
                                        var header = ["Authorization" : "SSWS 00QRhOZHw3eQm6VK-Ma_NqNbu7uhzN4bc3OeF7l-SG"]
                                        var validSessionUrl = "https://vanbeektech.okta.com/api/v1/sessions/" + cookie
                                        Alamofire.request(validSessionUrl, headers: header)
                                            .responseJSON { response in
                                                
                                                guard response.result.error != nil else {
                                                    // got an error in getting the data, need to handle it
                                                    print("Got a valid session!!!!")
                                                    if let result = response.result.value {
                                                        let JSON = result as! NSDictionary
                                                        print(JSON)
                                                        cookie = JSON["id"] as! String
                                                        print("cheeky")
                                                        status = JSON["status"] as! String
                                                        print("status")
                                                        if(status == "ACTIVE"){
                                                        let secondViewController:UIViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "secondview") as UIViewController
                                                        // .instantiatViewControllerWithIdentifier() returns AnyObject! this must be downcast to utilize it
                                                        
                                                        self.present(secondViewController, animated: false, completion: nil)
                                                        }
                                                        
                                                    }
                                                    return
                                                }

                                        }
                                    }
                                    return
                                }
                                // make sure we got some JSON since that's what we expect
                        }

                    }

                    
                    print("thing")
                    return
                }
                    return
                }
                // make sure we got some JSON since that's what we expect
        }
                
    }

}


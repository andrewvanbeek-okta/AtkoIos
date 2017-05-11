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
import AppAuth

var appConfig = OktaConfiguration()

// AppAuth authState
var authState:OIDAuthState?


// Revoked Toggle
var userId = String()
var revoked = false
var returnValue: Any?
var authRespDictionary: NSDictionary?


class CommonViewController : UIViewController, OIDAuthStateChangeDelegate {
    
//
    func createAlert(_ alertTitle: String, alertMessage: String) {
        let alert = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.cancel, handler: nil))
        let textIndicator: UIActivityIndicatorView = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50)) as UIActivityIndicatorView
        alert.view.addSubview(textIndicator)
        
        present(alert, animated: true, completion: nil)
    }
    
    

    
func setAuthState(_ authStatenow:OIDAuthState?){
        authState = authStatenow
        authState?.stateChangeDelegate = self
        self.stateChanged()
    }
    
    /**  Saves the current authState into NSUserDefaults  */
    func saveState() {
        if(authState != nil){
            let archivedAuthState = NSKeyedArchiver.archivedData(withRootObject: authState!)
            UserDefaults.standard.set(archivedAuthState, forKey: appConfig.kAppAuthExampleAuthStateKey)
        }
        else { UserDefaults.standard.set(nil, forKey: appConfig.kAppAuthExampleAuthStateKey) }
        
        UserDefaults.standard.synchronize()
        
    }
    
    /**  Loads the current authState from NSUserDefaults */
    func loadState() {
        if let archivedAuthState = UserDefaults.standard.object(forKey: appConfig.kAppAuthExampleAuthStateKey) as? Data {
            if let authState = NSKeyedUnarchiver.unarchiveObject(with: archivedAuthState) as? OIDAuthState {
                setAuthState(authState)
            } else {  return  }
        } else { return }
        

    }
    

    
    /**
     *  Setter method for authState update
     *  :param: authState The input value representing the new authorization state
     */

    
    /**  Required method  */
    func stateChanged(){ self.saveState() }
    
    /**  Required method  */
    func didChange(_ state: OIDAuthState) { self.stateChanged() }
    
    /**  Verifies authState was performed  */
    func checkAuthState() -> Bool {
        if (authState != nil){
            return true
        } else { return false }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        refreshTokens()
        var timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(CommonViewController.checker), userInfo: nil, repeats: true)
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
    
    func checker (){
           }
    func refreshTokens(){
        if checkAuthState() {
            print("Refreshed tokens")
            authState?.setNeedsTokenRefresh()
            authState?.performAction(freshTokens: {
                accessToken, idToken, error in
                if(error != nil){
                    print("Error fetching fresh tokens: \(error!.localizedDescription)")
                    self.createAlert("Error", alertMessage: "Error fetching fresh tokens")
                    return
                }
            })
        } else {
            print("Not authenticated")
            createAlert("Error", alertMessage: "Not authenticated")
        }
    }

}


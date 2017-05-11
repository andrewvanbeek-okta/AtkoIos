//
//  AppsController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/22/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//

import Foundation

//
//  ContactsController.swift
//  Mobile-Sign
//
//  Created by Andrew Van Beek on 4/20/17.
//  Copyright © 2017 Andrew Van Beek. All rights reserved.
//


import UIKit

import Alamofire



class AppsController: UITableViewController {
    
    
    
    //MARK: INSTANCE VARIABLES & CONSTANTS
    
    var table = ["Loading Users", "YUCJ"]
    
    
    
    //MARK: FUNCTIONS
    
    func siteInfo() -> Void {
        
        var url = "https://dev-885515.oktapreview.com/api/v1/users/\(userId)/appLinks"
        if(token != nil){
            let header: [String : String] = ["Authorization" : "SSWS 0062IiqfTB-b2MwADd5l7XEJLrQXJHl0CW079NrdUg"]
            Alamofire.request(url, headers: header).responseJSON{ response in
                var tableInfoToBeInserted = [String]()
                guard response.result.error != nil else {
                    
                    // got an error in getting the data, need to handle it
                    let json = response.result.value as! NSArray
                    for i in 0 ..< json.count  {
//                        let userInfoBlob = json[i] as! NSDictionary
//                        let profile = userInfoBlob["profile"] as! NSDictionary
//                        print(profile)
//                        let firstName = profile["firstName"] as! String
//                        let lastName = profile["lastName"] as! String
//                        let name = "\(firstName) \(lastName)"
//                        let email = profile["email"] as! String
//                        let userString = "Name: \(name.capitalized), \n Email: \(email.capitalized)"
//                        tableInfoToBeInserted.append(userString)
                    }
//                    print(tableInfoToBeInserted)
//                    self.table = tableInfoToBeInserted as! NSArray as! [String]
//                    self.tableView.reloadData()
                    return
                }
                
            }
        }
        
        
        //          //
        
        
        
        
    }
    
    
    
    //MARK: OVERRIDE FUNCTIONS
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        //        UINavigationBar.appearance().barTintColor = UIColor(red: 23.0/255.0, green: 46.0/255.0, blue: 173.0/255.0, alpha: 1.0)
        //
        //        UINavigationBar.appearance().tintColor = UIColor.white
        //
        //        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        //
        siteInfo()
        
        print(table)
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        
        siteInfo()
        
    }
    
    
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (table.count)
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.numberOfLines = 10
        cell.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        cell.textLabel?.text = table[indexPath.row]
        cell.backgroundColor = .clear
        let image = UIImage(named: "tablebg.png")
        let imageView = UIImageView(image: image)
        //        self.tableView.backgroundView = imageView
        //        imageView.contentMode = .scaleAspectFit
        
        
        let screenSize: CGRect = UIScreen.main.bounds
        let screenWidth = screenSize.width
        let scale: CGFloat = CGFloat(table.count)
        let screenHeight = screenSize.height * scale
        imageView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        view.addSubview(imageView)
        view.sendSubview(toBack: imageView)
        cell.textLabel?.font = UIFont(name:"Futura", size:14)
        cell.textLabel?.textColor = UIColor.white
        
        return cell
        
    }
    
    
    
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath)
        
    {
        
        if editingStyle == UITableViewCellEditingStyle.delete
            
        {
            
            var deletion = table[indexPath.row]
            
            var itemInfo = ["list_id": 1, "name": deletion] as [String : Any]
            
            Alamofire.request("http://localhost:3000/users/1", method: .delete, parameters: ["item": itemInfo], encoding: JSONEncoding.default)
                
                .responseJSON { response in
                    
            }
            
            table.remove(at: indexPath.row)
            
            tableView.reloadData()
            
        }
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
        return 80.0;//Choose your custom row height
    }
    
    
    
}


/*
 
 // Override to support conditional editing of the table view.
 
 override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
 
 // Return false if you do not want the specified item to be editable.
 
 return true
 
 }
 
 */


/*
 
 // Override to support editing the table view.
 
 override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
 
 if editingStyle == .delete {
 
 // Delete the row from the data source
 
 tableView.deleteRows(at: [indexPath], with: .fade)
 
 } else if editingStyle == .insert {
 
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 
 }
 
 }
 
 */


/*
 
 // Override to support rearranging the table view.
 
 override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
 
 
 
 }
 
 */


/*
 
 // Override to support conditional rearranging of the table view.
 
 override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
 
 // Return false if you do not want the item to be re-orderable.
 
 return true
 
 }
 
 */


/*
 
 // MARK: - Navigation
 
 
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 
 // Get the new view controller using segue.destinationViewController.
 
 // Pass the selected object to the new view controller.
 
 */

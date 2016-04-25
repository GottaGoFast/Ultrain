//
//  LoginVC.swift
//  Ultrain
//
//  Created by Yifu Ma on 2/26/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    var dataToPass:NSDictionary!
    @IBOutlet weak var Username: UITextField!
    @IBOutlet weak var Password: UITextField!
        
    
    @IBAction func SignupTapped(sender: UIButton) {
        
    }
    
    
    @IBAction func LoginTapped(sender: UIButton) {
        let usernameString:NSString = Username.text! as NSString
        let passwordString:NSString = Password.text! as NSString
        
        if(usernameString.isEqualToString("") || passwordString.isEqualToString("")){
            popAlert("Login Failed", message: "Please enter username and password")
        }
        else if (usernameString.isEqualToString("seedzeng@gmail.com") || passwordString.isEqualToString("seedzeng")){
            var seedData : NSDictionary = ["id" : 1, "level" : "trainee", "auth_token" : "10d89d4cabf1a5eb983ef8a90ef48c23971fc9d40ffe9acfad07d357", "user" : ["email" : "cdzengpeiyun@gmail.com",  "username": "seedZeng", "first_name": "Seed", "last_name": "Zeng"], "profile" : "I love to workout", "profile" : "most determined trainee you'll ever see", "goal": "Lose 30 pounds in 3 weeks", "profile_pic" : "https://www.google.com/"]
            var seedProfile : NSDictionary = ["email" : "cdzengpeiyun@gmail.com",  "username": "seedZeng", "first_name": "Seed", "last_name": "Zeng"]
            APIProxy.sharedInstance.setRawData(seedData)
            APIProxy.sharedInstance.setUserInfo(seedProfile)
            self.performSegueWithIdentifier("loginToMainView", sender: self)
        }
        else{
            let returnedResult:NSDictionary = APIProxy.sharedInstance.login(usernameString,password: passwordString)
            let status = returnedResult.valueForKey("status")
            if(status != nil && status as! String == "success"){
                self.popAlert("Success", message: "you have logged in")
                let raw:NSDictionary = returnedResult.valueForKey("data") as! NSDictionary
                APIProxy.sharedInstance.setRawData(raw)
                APIProxy.sharedInstance.setUserInfo(raw.valueForKey("user") as! NSDictionary)
                self.performSegueWithIdentifier("loginToMainView", sender: self)
            }
            else{
                self.popAlert("Failure", message: "Login failed")
            }
            
        }
        
    }
    
    
    
    func popAlert(title:String, message:String){
        let alertView:UIAlertView = UIAlertView()
        alertView.title = title
        alertView.message = message
        alertView.delegate = self
        alertView.addButtonWithTitle("OK")
        alertView.show()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "loginToMainView") {
            let calView = segue.destinationViewController as! SWRevealViewController;
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

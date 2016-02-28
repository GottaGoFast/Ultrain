//
//  LoginVC.swift
//  Ultrain
//
//  Created by Yifu Ma on 2/26/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

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
        else{
            let loginString = NSString(format: "%@:%@", usernameString, passwordString)
            let loginData: NSData = loginString.dataUsingEncoding(NSUTF8StringEncoding)!
            let base64LoginString = loginData.base64EncodedStringWithOptions([])
            
            let url = NSURL(string: "engineering.wustl.edu/cse")!
            
            let config = NSURLSessionConfiguration.defaultSessionConfiguration()
            let authString = "Basic \(base64LoginString)"
            config.HTTPAdditionalHeaders = ["Authorization" : authString]
            let session = NSURLSession(configuration: config)
            
            session.dataTaskWithURL(url) {
                (let data, let response, let error) in
                if let httpResponse = response as? NSHTTPURLResponse {
                    do{
                        let incomingData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                        
                        let success:NSInteger = incomingData.valueForKey("success") as! NSInteger
                        if(success == 1){
                            self.popAlert("Success", message: "Logged in!")
                            let calendarView = self.storyboard?.instantiateViewControllerWithIdentifier("calendarView") as! CalendarView
                            calendarView.loadTextField(incomingData as! NSDictionary)
                            self.performSegueWithIdentifier("loginToMainView", sender: nil)
                        }
                        else{
                            self.popAlert("Failure", message: "Failed to login")
                        }
                        
                    } catch{
                        self.popAlert("Error", message: "Failed to parse response from server")
                    }
                }
                }.resume()
            
        }
        
    }
    
    func switchToMainView(data:NSDictionary){
        
        self.performSegueWithIdentifier("loginToMainView", sender: <#T##AnyObject?#>)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

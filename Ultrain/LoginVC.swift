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
        else{
            let proxy = APIProxy()
            let returnedResult:NSDictionary = proxy.login(usernameString,password: passwordString)
            let status = returnedResult.valueForKey("status")
            if(status != nil && status as! String == "success"){
                self.popAlert("Success", message: "you have logged in")
                switchToMainView(returnedResult.valueForKey("data") as! NSDictionary)
            }
            else{
                self.popAlert("Failure", message: "Login failed")
            }
            
        }
        
    }
    
    func switchToMainView(data:NSDictionary){
        self.dataToPass = data
        self.performSegueWithIdentifier("loginToMainView", sender: self)
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
            let calView = segue.destinationViewController as! CalendarView;
            calView.data = dataToPass
            
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

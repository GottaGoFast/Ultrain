//
//  SignupVC.swift
//  Ultrain
//
//  Created by Yifu Ma on 2/28/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {
    var data:NSDictionary!
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var typeSwitch: UISwitch!
    @IBOutlet weak var typeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func switchPressed(sender: AnyObject) {
        if(typeSwitch.on){
            typeLabel.text = "Sign up as a Trainee!"
        }
        else{
            typeLabel.text = "Sign up as a Trainer!"
        }
    }
    
    @IBAction func backToLogIn(sender: UIButton) {
        
    }
    @IBAction func SignupTapped(sender: UIButton) {
        var type = ""
        if(typeSwitch.on){
            type = "Trainee"
        }
        else{
            type = "Trainer"
        }
        let nameString = NameField.text! as NSString
        let username = UsernameField.text! as NSString
        let password = PasswordField.text! as NSString
        
        if(nameString.isEqualToString("") || username.isEqualToString("") || password.isEqualToString("")){
            self.popAlert("Error", message: "The above fields cannot be empty!")
        }
        else{
        
            let proxy = APIProxy()
            let returnedResult:NSDictionary = proxy.signup(nameString as String, email: username as String, password: password as String, type: type)
            let status = returnedResult.valueForKey("status")
            if(status != nil && status as! String == "success"){
                self.popAlert("Success", message: "you have signed up")
                self.data = returnedResult
                self.performSegueWithIdentifier("signupToMainView", sender: self)
            }
            else{
                self.popAlert("Failure", message: "This email has been used!")
            }
        }
        
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "signupToMainView") {
            let calView = segue.destinationViewController as! CalendarView;
            calView.data = data
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

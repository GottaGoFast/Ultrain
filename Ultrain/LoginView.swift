//
//  LoginView.swift
//  Ultrain
//
//  Created by Yifu Ma on 2/26/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class LoginView: UIViewController {

    @IBOutlet weak var loginAlert: UITextView!
    @IBOutlet weak var PasswordField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    override func viewDidLoad() {
        loginAlert.hidden = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loginTapped(sender: UIButton) {
        var Username:NSString = UsernameField.text! as NSString
        var Password:NSString = PasswordField.text! as NSString
        
        if(Username.isEqualToString("") || Password.isEqualToString("")){
            loginAlert.hidden = false
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

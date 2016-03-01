//
//  SignupVC.swift
//  Ultrain
//
//  Created by Yifu Ma on 2/28/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var UsernameField: UITextField!
    @IBOutlet weak var PasswordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backToLogIn(sender: UIButton) {
        
    }
    @IBAction func SignupTapped(sender: UIButton) {
        let nameString = NameField.text! as NSString
        let username = UsernameField.text! as NSString
        let password = PasswordField.text! as NSString
        
        
        
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

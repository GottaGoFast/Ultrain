//
//  CalendarView.swift
//  Ultrain
//
//  Created by Yifu Ma on 2/28/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class CalendarView: UIViewController {

    @IBOutlet weak var textField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadTextField(data:NSDictionary){
        var textToShow:String = ""
        let enumerator = data.keyEnumerator()
        while let key = enumerator.nextObject(){
            textToShow = textToShow + (key as! String)
        }
        textField.text = textToShow
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

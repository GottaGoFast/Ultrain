//
//  Profile.swift
//  
//
//  Created by Yifu Ma on 4/1/16.
//
//

import UIKit

class Profile: UITableViewController {
    @IBOutlet weak var menuButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let userInfo : NSDictionary = APIProxy.sharedInstance.userInfo
        let raw : NSDictionary = APIProxy.sharedInstance.rawData
        let url = NSURL(string: raw.valueForKey("profile_pic") as! String)
        let imageData = NSData(contentsOfURL: url!)
        
        if(userInfo.valueForKey("first_name") as! String == "Seed"){
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ProfileCell
            cell.profilePic.image = UIImage(named: "1259174914.jpg")
            cell.fName.text = userInfo.valueForKey("first_name") as! String
            cell.lName.text = userInfo.valueForKey("last_name") as! String
            cell.goal.text = raw.valueForKey("goal") as! String
            cell.profileIntro.text = raw.valueForKey("profile") as! String
            return cell

        }
        else if(raw.valueForKey("level") as! String == "TRAINER"){
            let cell = tableView.dequeueReusableCellWithIdentifier("TCell", forIndexPath: indexPath) as! TrainerProfileCell
            cell.profilePic.image = UIImage(data: imageData!)
            cell.fName.text = userInfo.valueForKey("first_name") as! String
            cell.lName.text = userInfo.valueForKey("last_name") as! String
            cell.pastExperience.text = raw.valueForKey("past_experience") as! String
            cell.Introduction.text = "strongest trainer you'll ever see"
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ProfileCell
            cell.profilePic.image = UIImage(data: imageData!)
            cell.fName.text = userInfo.valueForKey("first_name") as! String
            cell.lName.text = userInfo.valueForKey("last_name") as! String
            cell.goal.text = raw.valueForKey("goal") as! String
            cell.profileIntro.text = "most determined trainee you'll ever see"
            return cell
        // Configure the cell...
        }
        
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  Workouts.swift
//  Ultrain
//
//  Created by Yifu Ma on 4/1/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import UIKit

class Workouts: UITableViewController {

    @IBOutlet weak var menuButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        if(APIProxy.sharedInstance.userInfo.valueForKey("first_name") as! String == "Seed"){
            var currWorkoutData = [NSDictionary]()
            currWorkoutData.append(["overview" : "Crazy Workout", "activities" : [["name": "Cardio Burning", "detail": "run for 100 miles"], ["name": "Weight Lifting", "detail": "Do you even Lift?"]]])
            currWorkoutData.append(["overview" : "Abs Shreader", "activities" : [["name": "Crunches", "detail": "do 100 crunches"], ["name": "leg raise", "detail": "do 25 leg raises"]]])
            APIProxy.sharedInstance.workout = currWorkoutData
        }
        else{
            APIProxy.sharedInstance.getWorkout()

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
        return APIProxy.sharedInstance.workout.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! genWorkoutCell
        let currWorkout = APIProxy.sharedInstance.workout[indexPath.row]
        cell.lable.text = "Tap to view detail..." 
        cell.genWorkoutName.text = currWorkout.valueForKey("overview") as! String

        // Configure the cell...

        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        APIProxy.sharedInstance.currentWorkoutNum = indexPath.row
 //       self.performSegueWithIdentifier("detWorkoutView", sender: self)
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

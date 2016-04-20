//
//  APIProxy.swift
//  Ultrain
//
//  Created by Yifu Ma on 2/29/16.
//  Copyright © 2016 Yifu Ma. All rights reserved.
//

import Foundation

let url = NSURL(string: "engineering.wustl.edu/cse")!

class APIProxy{
    
    static let sharedInstance = APIProxy()
    
    var userInfo:NSDictionary = ["data" : " "]
    
    var rawData:NSDictionary = ["data" : " "]
    
    var workout = [NSDictionary]()
    
    var currentWorkoutNum:Int = 0
    
    private init(){
        print("instance initiated")
    }
    
    func setUserInfo(data:NSDictionary){
        userInfo = data
    }
    
    func setRawData(data:NSDictionary){
        rawData = data
    }
    
    
    func login(email:NSString, password:NSString) -> NSDictionary{
        let loginString = String(format: "%@:%@", email, password)
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "POST"
        request.setValue(loginString, forHTTPHeaderField: "Authorization")
        var ret:NSDictionary = NSDictionary()
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        session.dataTaskWithRequest(request, completionHandler: {
            (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if (data != nil) {
                do{
                    let incomingData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    let token:String = incomingData.valueForKey("auth_token") as! String
                    if(!token.isEmpty){
                        ret.setValue("success", forKey: "status")
                        ret.setValue(incomingData, forKey: "data")
                        
                    }
                    else{
                        ret.setValue("failure", forKey: "status")
                    }
                    
                } catch{
                    ret.setValue("error", forKey: "error")
                }
                dispatch_semaphore_signal(semaphore)
            }else{
                ret.setValue("failure", forKey: "status")
                ret.setValue("No data returned", forKey: "error")
                dispatch_semaphore_signal(semaphore)
            }
        }).resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)

        return ret
    }
 
    func signup(name:String, email:String, password:String, type:String) -> NSDictionary{
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.setValue(name, forHTTPHeaderField: "Name")
        request.setValue(email, forHTTPHeaderField: "Email")
        request.setValue(password, forHTTPHeaderField: "Password")
        request.setValue(type, forHTTPHeaderField: "Type")
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        var ret:NSDictionary = NSDictionary()
        session.dataTaskWithRequest(request, completionHandler: {
            (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if (data != nil) {
                do{
                    let incomingData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    let token:String = incomingData.valueForKey("auth_token") as! String
                    if(!token.isEmpty){
                        ret.setValue("success", forKey: "status")
                        ret.setValue(incomingData, forKey: "data")
                        
                    }
                    else{
                        ret.setValue("failure", forKey: "status")
                    }
                    
                } catch{
                    ret.setValue("error", forKey: "error")
                }
                dispatch_semaphore_signal(semaphore)
            }else{
                ret.setValue("failure", forKey: "status")
                ret.setValue("No data returned", forKey: "error")
                dispatch_semaphore_signal(semaphore)
            }
        }).resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        return ret
        
    }
    
    func getWorkout(){
        let session = NSURLSession.sharedSession()
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "GET"
        request.setValue(rawData.valueForKey("auth_token") as! String, forHTTPHeaderField: "auth_token")
        var ret:NSDictionary = NSDictionary()
        let semaphore: dispatch_semaphore_t = dispatch_semaphore_create(0)
        session.dataTaskWithRequest(request, completionHandler: {
            (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in
            if (data != nil) {
                do{
                    let incomingData = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)
                    
                    let workout:NSDictionary = incomingData.valueForKey("workouts") as! NSDictionary
                    if(workout.count != 0){
                    
                        ret = workout
                        
                    }
                    else{
                        ret.setValue("failure", forKey: "status")
                    }
                    
                } catch{
                    ret.setValue("error", forKey: "error")
                }
                dispatch_semaphore_signal(semaphore)
            }else{
                ret.setValue("failure", forKey: "status")
                ret.setValue("No data returned", forKey: "error")
                dispatch_semaphore_signal(semaphore)
            }
        }).resume()
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER)
        
        self.workout = ret.valueForKey("workouts") as! [NSDictionary]

        
    }

}



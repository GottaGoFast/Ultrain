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
                    
                    let success:NSInteger = incomingData.valueForKey("success") as! NSInteger
                    if(success == 1){
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
                    
                    let success:NSInteger = incomingData.valueForKey("success") as! NSInteger
                    if(success == 1){
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

}



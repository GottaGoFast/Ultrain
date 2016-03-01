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
        session.dataTaskWithRequest(request) {
            (let data, let response, let error) in
            if let httpResponse = response as? NSHTTPURLResponse {
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
            }
            }.resume()
        return ret
        
    }
    
}


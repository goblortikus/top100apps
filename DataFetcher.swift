//
//  DataFetcher.swift
//  dashboardmonirmamoun
//
//  Created by MM on 5/6/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import Foundation

class DataFetcher: NSObject, NSURLConnectionDataDelegate {
    let url: String
    
    var receivedData: NSMutableData!
    
    init(url: String) {
        self.url = url
        super.init()
        
        if let url = NSURL(string: url) {
            let urlRequest = NSURLRequest(URL: url)
            NSURLConnection(request: urlRequest, delegate: self)
        } else {
            reportFailure("Could not create NSURL")
        }
    }
    
    deinit {
        println("The Data Fetcher for '\(url)' is being deallocated")
    }
    
    func reportFailure(message: String) {
        println(message)
    }
    
    /* START NSURLConnectionDataDelegate protocol methods */
    
    func connection(connection: NSURLConnection, didReceiveResponse response: NSURLResponse) {
       receivedData = NSMutableData()
    }
    
    func connection(connection: NSURLConnection, didReceiveData data: NSData) {
       receivedData.appendData(data)
    }

    func connectionDidFinishLoading(connection: NSURLConnection) {
        convertDataToJSON()
    }
    
    func connection(connection: NSURLConnection, didFailWithError error: NSError) {
        reportFailure(error.description)
    }
    
    /* END NSURLConnectionDataDelegate protocol methods */
    
    func convertDataToJSON() {
        var error : NSError?
        
        let jsonObject : AnyObject? = NSJSONSerialization.JSONObjectWithData(receivedData, options: NSJSONReadingOptions.AllowFragments, error: &error)
        
        if error == nil {
            if let dataDict = jsonObject as? NSDictionary {
                //println("\(dataDict)")
                if let entries = dataDict["feed"]?["entry"] as? [NSDictionary]{
                    var titles = [String]()
                    for (index, entry) in enumerate(entries) {
                        if let title = entry["title"]?["label"] as? String {
                            titles.append(title)
                        } else {
                            reportFailure("Could not get title for item \(index + 1)")
                        }
                    }
                    println("\(titles)")
                } else {
                    reportFailure("Entries array could not be found")
                }
                
            } else {
                reportFailure("Error: converted JSON data is not an NSDictionary")
            }
        } else {
            reportFailure("Error: NSJSONSerialization couldn't convert receivedData")
        }
    }
}
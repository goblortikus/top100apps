//
//  ViewController.swift
//  dashboardmonirmamoun
//
//  Created by MM on 5/6/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, DataFetcherDelegate {

    @IBOutlet weak var searchTerms: NSTextField!
    
    
    @IBAction func goButton(sender: NSButton) {
        goFetch()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        goFetch()
    }
    
    func goFetch() {
        let fetcher = DataFetcher(url: "https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json", delegate: self)
    }
    
    func fetchSuccess(titles: [String], url: String) {
        println("Request: '\(url)' succeeded!")
        
        var filteredArray = titles;
        
        if !searchTerms.stringValue.isEmpty  {
            println("searchterms value ")
            println(searchTerms.stringValue)
            filteredArray = filteredArray.filter({ ($0 as String).rangeOfString(self.searchTerms.stringValue) != nil})
        }
        
        
        for (position, title) in enumerate(filteredArray) {
            println("Position  \(position + 1): \(title)")
        }
    }

    func fetchFailure(message: String, url: String) {
        println("Request: '\(url)' failed for the following reason: '\(message)'")
    }


}


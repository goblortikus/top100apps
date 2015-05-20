//
//  ViewController.swift
//  dashboardmonirmamoun
//
//  Created by MM on 5/6/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, DataFetcherDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let fetcher = DataFetcher(url: "https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json", delegate: self)
    }

    func fetchSuccess(titles: [String], url: String) {
        println("Request: '\(url)' succeeded!")
        
        for (position, title) in enumerate(titles) {
            println("Position  \(position + 1): \(title)")
        }
    }

    func fetchFailure(message: String, url: String) {
        println("Request: '\(url)' failed for the following reason: '\(message)'")
    }


}


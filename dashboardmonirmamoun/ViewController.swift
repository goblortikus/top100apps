//
//  ViewController.swift
//  dashboardmonirmamoun
//
//  Created by MM on 5/6/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let fetcher = DataFetcher(url: "https://itunes.apple.com/us/rss/toppaidapplications/limit=100/json")
    }




}


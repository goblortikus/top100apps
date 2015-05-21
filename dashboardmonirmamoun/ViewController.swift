//
//  ViewController.swift
//  dashboardmonirmamoun
//
//  Created by MM on 5/6/15.
//  Copyright (c) 2015 MM. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, DataFetcherDelegate {
    
    var isAndSearch: Bool = true;

    @IBOutlet weak var searchTerms: NSTextField!
    
    @IBOutlet var searchResultTextView: NSTextView!
    
    @IBAction func goButton(sender: NSButton) {
        goFetch()
    }
    
    @IBAction func andOrSearchTypeAction(sender: NSMatrix) {
        isAndSearch = (sender.selectedCell().tag() == 1)
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
        
        var filteredArray = titles
        var filteredSet: Set<String>?
        
        if !searchTerms.stringValue.isEmpty  {
            
            let searchTermsArray = searchTerms.stringValue.componentsSeparatedByString(" ")
            
            if isAndSearch {
                for term in searchTermsArray{
                    filteredArray = filteredArray.filter({ ($0 as String).rangeOfString(term) != nil})
                }
            } else {
                filteredSet = Set<String>()
                for term in searchTermsArray{
                    // can union a set with an array (because array is Sequence type)
                    filteredSet = filteredSet!.union(filteredArray.filter({ ($0 as String).rangeOfString(term) != nil}))
                }
            }
        }
        
        searchResultTextView.string = ""
        
        // something tells me the enumerate construct below is a bit audacious. But I love it.
        // Basically I want to use the nil coalescing operator ?? with Set<String> and [String], but with NCO both sides must be of SAME type.
        // So for the array on the right, I create an empty Set<String> and union with the array (essentially casting it to Set<String>)
        for (position, title) in enumerate(filteredSet ?? Set<String>().union(filteredArray)) {
            searchResultTextView.textStorage?.appendAttributedString(NSAttributedString(string: "Position  \(position + 1): \(title)\n"))
            println("Position  \(position + 1): \(title)")
        }

    }

    func fetchFailure(message: String, url: String) {
        println("Request: '\(url)' failed for the following reason: '\(message)'")
    }
}


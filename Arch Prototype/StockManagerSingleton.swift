//
//  StockManagerSingleton.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/22/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation
//
//  StockManagerSingleton.swift
//  SwiftStocks
//
//  Created by David Brodsky on 7/20/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation
let kNotificationStocksUpdated = "stocksUpdated"

class StockManagerSingleton {
    
    //Singleton Init
    class var sharedInstance : StockManagerSingleton {
        struct Static {
            static let instance : StockManagerSingleton = StockManagerSingleton()
        }
        return Static.instance
    }
    
    /*!
    * @discussion Function that given an array of symbols, get their stock prizes from yahoo and send them inside a NSNotification UserInfo
    * @param stocks An Array of tuples with the symbols in position 0 of each tuple
    */
    func updateListOfSymbols(stocks: [(String,Double)]) ->() {
        
        //1: YAHOO Finance API: Request for a list of symbols example:
        //http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN ("AAPL","GOOG","FB")&format=json&env=http://datatables.org/alltables.env
        
        //2: Build the URL as above with our array of symbols
        var stringQuotes = "(";
        for quoteTuple in stocks {
            stringQuotes += "\"+\(quoteTuple.0)\","
        }
        stringQuotes = stringQuotes.substringToIndex(stringQuotes.endIndex.predecessor())  //gets rid of last comma
        stringQuotes += ")"
        
        let urlString = ("http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN "+stringQuotes+"&format=json&env=http://datatables.org/alltables.env").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
        let url = NSURL(string: urlString)!
        let request = NSURLRequest(URL:url)
        let config = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: config)
        
        //3: Completion block/Clousure for the NSURLSessionDataTask
        let task : NSURLSessionDataTask = session.dataTaskWithRequest(request){
            (let data, let response, let error) in
            
            if((error) != nil) {
                print(error!.localizedDescription)
            }
            else {
                var err: NSError?
                //4: JSON process
                let jsonDict = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                if(err != nil) {
                    print("JSON Error \(err!.localizedDescription)")
                }
                else {
                    //5: Extract the Quotes and Values and send them inside a NSNotification
                    let quotes:NSArray = ((jsonDict.objectForKey("query") as! NSDictionary).objectForKey("results") as! NSDictionary).objectForKey("quote") as! NSArray
                    dispatch_async(dispatch_get_main_queue(), {
                        NSNotificationCenter.defaultCenter().postNotificationName(kNotificationStocksUpdated, object: nil, userInfo: [kNotificationStocksUpdated:quotes])
                    })
                }
            }
        }
        
        //6: DONT FORGET to LAUNCH the NSURLSessionDataTask!!!!!!
        task.resume()
    }
}
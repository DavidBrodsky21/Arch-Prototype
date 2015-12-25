////
////  yahooQuery.swift
////  Arch Prototype
////
////  Created by David Brodsky on 7/22/15.
////  Copyright (c) 2015 Arch Developers. All rights reserved.
////
//
//import Foundation
//
//struct yahooQuery{
//    
//    //SWIFT-STOCKS
//    //1: YAHOO Finance API: Request for a list of symbols example:
//    //http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN ("AAPL","GOOG","FB")&format=json&env=http://datatables.org/alltables.env
//    
//    let ticker: String?
//    
//    init(tickerRequested: String){
//        ticker = tickerRequested
//    }
//    
//    func getStockQuotes (completion: (StockQuote? -> Void)) {
//        let urlString = ("http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN (\"\(ticker)\")&format=json&env=http://datatables.org/alltables.env").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        
//        if let yqlURL = NSURL(string: urlString) {
//            
//            let networkOperation = NetworkOperation(url: yqlURL)
//            networkOperation.downloadJSONFromURL {
//                (let JSONDictionary) in
//                let stockQuote = StockQuote(stockQuoteDict: JSONDictionary!)
//                completion(stockQuote)
//            }
//        } else {
//            print("Could not construct a valid URL", terminator: "")
//        }
//        
//    }
//}
//
///*
////let stocksList = ["GOOG", "AAPL", "VZ", "MRK"]
//
//struct yahooQuery{
//    
////SWIFT-STOCKS
//    //1: YAHOO Finance API: Request for a list of symbols example:
//    //http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN ("AAPL","GOOG","FB")&format=json&env=http://datatables.org/alltables.env
//
//    let ticker: String?
//    
//    init(tickerRequested: String){
//        ticker = tickerRequested
//    }
//
//    func getStockQuotes (completion: (StockQuote? -> Void)) {
//        var urlString = ("http://query.yahooapis.com/v1/public/yql?q=select * from yahoo.finance.quotes where symbol IN (\"\(ticker)\")&format=json&env=http://datatables.org/alltables.env").stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
//        
//        if let yqlURL = NSURL(string: urlString) {
//            
//            let networkOperation = NetworkOperation(url: yqlURL)
//
//            networkOperation.downloadJSONFromURL {
//                (let JSONDictionary) in
//                let stockQuote = StockQuote(stockQuoteDict: JSONDictionary!)
//                completion(stockQuote)
//            }
//        } else {
//            println("Could not construct a valid URL")
//        }
//        
//    }
//}
//
//*/
//
//
//
//

//
//  YQL.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/23/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

struct YQL {
    private static let prefix:NSString = "https://query.yahooapis.com/v1/public/yql?&format=json&env=store%3A%2F%2Fdatatables.org%2Falltableswithkeys&callback=&q="
    
    static func query(queryStatement queryStatement: String) -> NSDictionary? {
        
        let escapedStatement = queryStatement.stringByAddingPercentEncodingWithAllowedCharacters(.URLHostAllowedCharacterSet())
        let query = "\(prefix)\(escapedStatement!)"
        
        var results:NSDictionary? = nil
        var jsonError:NSError? = nil
        
        let jsonData: NSData?
        do {
            jsonData = try NSData(contentsOfURL: NSURL(string: query)!, options: NSDataReadingOptions.DataReadingMappedIfSafe)
        } catch let error as NSError {
            jsonError = error
            jsonData = nil
        }
        
        do {
            if jsonData != nil {
                results = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.AllowFragments) as? NSDictionary
            }
        } catch {
            print("Error")
        }
        if jsonError != nil {
            NSLog( "ERROR while fetching/deserializing YQL data. Message \(jsonError!)" )
        }
        return results
    }
}

func makeQuery (tickers: [String]) -> String {
    var query = "("
    for ticker in tickers {
        query = query + "\"\(ticker)\","
    }
    return query.substringToIndex(query.endIndex.predecessor()) + ")"
}

func getQuotesDictionary(tickers: [String],  index: Int) -> [String: AnyObject]? {
    let tickersQuery: String = makeQuery(tickers)
    let queryStatement = "select * from yahoo.finance.quotes where symbol in \(tickersQuery)"
    //print(queryStatement)
    
    let results = YQL.query(queryStatement: queryStatement) //
    let queryResults = results?.valueForKeyPath("query.results") as! NSDictionary?
    
    let forPrint = queryResults?.objectForKey("quote")?.objectAtIndex(index) as! [String: AnyObject]?
    print(forPrint?.description)
    
    return queryResults?.objectForKey("quote")?.objectAtIndex(index) as! [String: AnyObject]?
    
}

func getQuoteDictionary(ticker: String) -> [String: AnyObject]? {
    let tickersQuery: String = "(\"\(ticker)\")"
    let queryStatement = "select * from yahoo.finance.quotes where symbol in \(tickersQuery)"
    print(queryStatement)
    
    let results = YQL.query(queryStatement: queryStatement) //
    let queryResults = results?.valueForKeyPath("query.results") as! NSDictionary?
    
    let forPrint = queryResults?.objectForKey("quote") as! [String: AnyObject]?
    print(forPrint?.description)
    
    return queryResults?.objectForKey("quote") as! [String: AnyObject]?
    
}





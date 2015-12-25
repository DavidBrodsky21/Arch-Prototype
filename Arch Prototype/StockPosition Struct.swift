//
//  Stock Struct.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/30/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

//May have to change later, but a given stock position flows directly from an executed trade, so there may be instances where
//a given ticker was purchased multiple times, but these would be distinct StockPositions.  Let's use a function on Archipelago
//to combine an array of such positions into a single one?

//These positions are for THE ENTIRE ARCHIPELAGO, not for the INDIVIDUAL'S SHARE
//MAY WANT TO CHANGE TO STRUCT

class StockPosition: Serializable {
    let ticker: String? //going to check 2 vars for "ticker"; may want to redo this and make it an if let later
    var shares: Int?
    let originalPurchasePrice: NSNumber?
    
    var stockQuote: StockQuote?
    
    init(executedTrade: ExecutedTrade, goGetQuote: Bool){
        
        ticker = executedTrade.ticker
        shares = executedTrade.shares
        originalPurchasePrice = executedTrade.priceExecuted
        
        super.init() //need to instantiate to run methods (see: http://stackoverflow.com/questions/28431011/swift-why-i-cant-call-method-from-override-init )
        
        if goGetQuote == true {
            getQuote()
        }
    }
    
    init(ticker: String, shares: Int, originalPurchasePrice: Double, goGetQuote: Bool){
        self.ticker = ticker
        self.shares = shares
        self.originalPurchasePrice = originalPurchasePrice
        
        super.init()
        
        if goGetQuote == true {
            getQuote()
        }
    }

    func getQuote() {
        if let tempDict = getQuoteDictionary(self.ticker!) {
            print("In getQuote")
            stockQuote = StockQuote(stockQuoteDict: tempDict)
            print("stockQuote.lastPrice: \(stockQuote?.lastTradePrice)")
        }
        else {
            print("Couldn't get current Price")
        }
    }
}





//Don't think I need this, but if need be include INSIDE struct above
//    func getCurrentPrice() {
//        if let tempDict = getQuoteDictionary(self.ticker!) {
//            if let currentPriceString = tempDict["LastTradePriceOnly"] as? String {
//                currentPrice = NSNumberFormatter().numberFromString(currentPriceString)!.doubleValue
//            }
//            println("Printing self.currentPrice: \(self.currentPrice)")
//        }
//        else {
//            println("Couldn't get current Price")
//        }
//    }
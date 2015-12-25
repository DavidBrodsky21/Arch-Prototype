//
//  StockQuote.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/22/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation
import UIKit

//MAKE SURE THAT ALL THE VARS HERE ARE IN THE NEW YQL SOURCE
struct StockQuote {
    var ticker: String? //going to check 2 vars for "ticker"; may want to redo this and make it an if let later
    var name: String?
    var dailyChangeDollar: Double?
    var dailyChangePct: Double? //going to check 2 vars for this var; may want to redo this and make it an if let later
    var currency: String?
    var daysLow: Double?
    var daysHigh: Double?
    var yearLow: Double?
    var yearHigh: Double?
    var marketCap: String? //Double? //note that "MarketCapitalization" from YQL comes as a string, e.g. "714.74B"
    var EBITDA: String? //Double?  //note that "EBITDA" from YQL comes as a string, e.g. "72.94B"
    var lastTradePrice: Double?
    var openPrice: Double?
    var previousClose: Double?
    var PERatio: Double?
    var volume: Int?
    var stockExchange: String?
    var dividendYield: Double?

    init(stockQuoteDict: [String: AnyObject]){
        if let tickerVal = stockQuoteDict["symbol"] as? String {
            ticker = tickerVal
        }
        if ticker == nil {
            if let tickerVal = stockQuoteDict["Symbol"] as? String {
                ticker = tickerVal
            }
        }
        if let nameVal = stockQuoteDict["Name"] as? String {
            name = nameVal
        }
        
        //Need to account for +/- in string
        if let dailyChangeDollarString = stockQuoteDict["Change"] as? String {
            var signVal: Double?
            let signChar = dailyChangeDollarString[dailyChangeDollarString.startIndex]
            let absValDailyChangeDollarString = dailyChangeDollarString.substringFromIndex(dailyChangeDollarString.startIndex.advancedBy(1))
            
            if signChar == "+" {
                signVal = 1.00
            } else if signChar == "-" {
                signVal = -1.00
            }
            
            if let absChange = NSNumberFormatter().numberFromString(absValDailyChangeDollarString)?.doubleValue,
                let sign = signVal {
                dailyChangeDollar = sign * absChange
            }
        }
        
        if let dailyChangePctString = stockQuoteDict["PercentChange"] as? String {
            var signVal: Double?
            let signChar = dailyChangePctString[dailyChangePctString.startIndex]
            let absValDailyChangePctString = dailyChangePctString.substringFromIndex(dailyChangePctString.startIndex.advancedBy(1)).substringToIndex(dailyChangePctString.endIndex.predecessor())
            
            if signChar == "+" {
                signVal = 1.00
            } else if signChar == "-" {
                signVal = -1.00
            }
  
            if let absChange = NSNumberFormatter().numberFromString(absValDailyChangePctString)?.doubleValue,
                let sign = signVal {
                    dailyChangePct = sign * absChange / 100.000
            }
        }
        
        if dailyChangePct == nil {
            if let dailyChangePctString = stockQuoteDict["ChangeinPercent"] as? String {
                var signVal: Double?
                let signChar = dailyChangePctString[dailyChangePctString.startIndex]
                let absValDailyChangePctString = dailyChangePctString.substringFromIndex(dailyChangePctString.startIndex.advancedBy(1)).substringToIndex(dailyChangePctString.endIndex.predecessor())
                
                if signChar == "+" {
                    signVal = 1.00
                } else if signChar == "-" {
                    signVal = -1.00
                }
                
                if let absChange = NSNumberFormatter().numberFromString(absValDailyChangePctString)?.doubleValue,
                    let sign = signVal {
                        dailyChangePct = sign * absChange / 100.000
                }
            }
        }
        
        
//        if let dailyChangePctVal = stockQuoteDict["PercentChange"] as? String {
//            let dailyChangePctVal = dailyChangePctVal.substringToIndex(dailyChangePctVal.endIndex.predecessor())
//                dailyChangePct = NSNumberFormatter().numberFromString(dailyChangePctVal)!.doubleValue / 100.000
//        }
//        if dailyChangePct == nil {
//            if let dailyChangePctVal = stockQuoteDict["ChangeinPercent"] as? String {
//                let dailyChangePctVal = dailyChangePctVal.substringToIndex(dailyChangePctVal.endIndex.predecessor())
//                dailyChangePct = NSNumberFormatter().numberFromString(dailyChangePctVal)!.doubleValue / 100.000
//            }
//        }
        
        if let currencyVal = stockQuoteDict["Currency"] as? String {
            currency = currencyVal
        }
        if let daysLowVal = stockQuoteDict["DaysLow"] as? String {
            daysLow = NSNumberFormatter().numberFromString(daysLowVal)!.doubleValue
        }
        if let daysHighVal = stockQuoteDict["DaysHigh"] as? String {
            daysHigh = NSNumberFormatter().numberFromString(daysHighVal)!.doubleValue
        }
        if let yearLowVal = stockQuoteDict["YearLow"] as? String {
            yearLow = NSNumberFormatter().numberFromString(yearLowVal)!.doubleValue
        }
        if let yearHighVal = stockQuoteDict["YearHigh"] as? String {
            yearHigh = NSNumberFormatter().numberFromString(yearHighVal)!.doubleValue
        }
        //Convert to Double
        if let marketCapVal = stockQuoteDict["MarketCapitalization"] as? String {
            marketCap = marketCapVal
        }
        //Convert to Double
        if let EBITDAVal = stockQuoteDict["EBITDA"] as? String {
            EBITDA = EBITDAVal
        }
        if let lastTradePriceVal = stockQuoteDict["LastTradePriceOnly"] as? String {
             lastTradePrice = NSNumberFormatter().numberFromString(lastTradePriceVal)!.doubleValue
        }
        if let openPriceVal = stockQuoteDict["Open"] as? String {
            openPrice = NSNumberFormatter().numberFromString(openPriceVal)!.doubleValue
        }
        if let previousCloseVal = stockQuoteDict["PreviousClose"] as? String {
            previousClose = NSNumberFormatter().numberFromString(previousCloseVal)!.doubleValue
        }
        if let PERatioVal = stockQuoteDict["PERatio"] as? String {
            PERatio = NSNumberFormatter().numberFromString(PERatioVal)!.doubleValue
        }
        if let volumeVal = stockQuoteDict["Volume"] as? String {
            volume = NSNumberFormatter().numberFromString(volumeVal)!.integerValue
        }
        if let stockExchangeVal = stockQuoteDict["StockExchange"] as? String {
            stockExchange = stockExchangeVal
        }
        if let dividendYieldVal = stockQuoteDict["DividendYield"] as? String {
            dividendYield = NSNumberFormatter().numberFromString(dividendYieldVal)!.doubleValue
        }
    }
}


/*Example of YQL query results; selected vars only
{"symbol":"AAPL",
"Change_PercentChange":"-6.685 - -5.113%",
"Change":"-6.685",
"Currency":"USD",
"DaysLow":"121.990",
"DaysHigh":"124.940",
"YearLow":"93.280",
"YearHigh":"134.540",
"MarketCapitalization":"714.74B",
"EBITDA":"72.94B",
//"ChangeFromYearLow":"30.785",
//"PercentChangeFromYearLow":"+33.003%",
//"ChangeFromYearHigh":"-10.475",
//"PercebtChangeFromYearHigh":"-7.786%", //Typo from JSON
"LastTradePriceOnly":"124.065",
//"FiftydayMovingAverage":"127.169",
//"TwoHundreddayMovingAverage":"124.729",
"Name":"Apple Inc.",
"Open":"122.050",
"PreviousClose":"130.750",
"ChangeinPercent":"-5.113%",
"PERatio":"15.419",
"Symbol":"AAPL",
"Volume":"61444011",
"StockExchange":"NMS",
"DividendYield":"1.600",
"PercentChange":"-5.113%"
}
*/



    
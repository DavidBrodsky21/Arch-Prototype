//
//  PortfolioHistory Struct.swift
//  Arch Prototype
//
//  Created by David Brodsky on 8/19/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

struct PortfolioHistoryEntry {
    var date: NSTimeInterval?
    var open: Bool?
    var stocksOwned: [StockPosition]?
    var availableCash: Double?
    
    init(){}
    
    //init from new trade
    init(executedTrade: ExecutedTrade, stocksOwnedPrior: [StockPosition], availableCashPrior: Double){
        self.date = executedTrade.dateExecuted
        self.open = false
        
        //self.stocksOwned
    }
    
    //init from it being a new day, we're getting a snapshot of portfolio at opening
    init(stocksOwnedPrior: [StockPosition], availableCashPrior: Double) {
        //self.date = executedTrade.dateExecuted
        self.open = true
        self.stocksOwned = stocksOwnedPrior
        self.availableCash = availableCashPrior
    }
    
    
    
}

struct PortfolioHistory {
    var portfolioHistoryEntries: [PortfolioHistoryEntry]
    
    init(){
        portfolioHistoryEntries = []
    }
}
//
//var proposal = Proposal(archipelago: archipelago1)
//var proposedTrade = ProposedTrade(archipelago: archipelago1, proposal: proposal)
//var execuTrade = ExecutedTrade(proposedTrade: proposedTrade)
//
//
//var portfolioHistEntry = PortfolioHistoryEntry(executedTrade: execuTrade, stocksOwnedPrior: [], availableCashPrior: archipelago1.availableCash)












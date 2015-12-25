//
//  Trade Structs.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/30/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

//TRADES
class ProposedTrade: Serializable {
    var actionType: String
    
    //PROPOSAL Vars
    var archipelago: String?
    var archipelagoID: String?
    var proposer: String
    
    // Will use Archipelago property to calculate time left until expiration
    var dateProposed: NSTimeInterval //NSDate
    var proposalLength: Int // take this from Arch characteristics; need to think about type
    var dateExpiring: NSTimeInterval? {
        get{
            let ProposalLengthSeconds: NSTimeInterval = Double(proposalLength) * 24.0 * 60.0 * 60.0
            return dateProposed + ProposalLengthSeconds
        }
    }
    
    //Section off this "voting" behavior in the future
    var numOfArchMembers: Int
    var yesVotes: Int
    var noVotes: Int
    var pendingVotes: Int

    //PROPOSED TRADES VARS
    var buyOrSell: String //buy or sell; make enum; potentially sub-type w/ limit vs. market or whatever
    //let orderType: orderType (enum)
    var ticker: String
    var shares: Int
    var limitPrice: NSNumber?
    
    override init(){
        actionType = "ProposedTrade"
        
        buyOrSell = "Buy"
        ticker = "MSFT"
        shares = 1
        limitPrice = 0.0
        self.archipelago = ""
        self.archipelagoID = ""
        self.proposer = ""
        self.dateProposed = NSDate().timeIntervalSince1970
        self.proposalLength = 1
        self.numOfArchMembers = 0
        self.yesVotes = 0
        self.noVotes = 0
        self.pendingVotes = 0
    }
    
    init(archipelago: Archipelago, proposal: Proposal){
        actionType = "ProposedTrade"
        
        buyOrSell = "Buy"
        ticker = "MSFT"
        shares = 1
        limitPrice = 0.0
        
        //super.init(archipelago: archipelago)
        
        //Proposal Properties
        self.archipelago = proposal.archipelago
        self.archipelagoID = proposal.archipelagoID
        self.proposer = proposal.proposer
        self.dateProposed = proposal.dateProposed
        self.proposalLength = proposal.proposalLength
        self.numOfArchMembers = proposal.numOfArchMembers
        self.yesVotes = proposal.yesVotes
        self.noVotes = proposal.noVotes
        self.pendingVotes = proposal.pendingVotes

    }
    
//    func populate(dictionary: NSDictionary){
//        self.setValuesForKeysWithDictionary(dictionary as [NSObject : AnyObject])
//    }
    
//    init(dictionary: NSDictionary) {
//        self.setValuesForKeysWithDictionary(dictionary as [NSObject : AnyObject])
//
////        setValue(dictionary["archipelago"], forKey: "archipelago")
//            //.valueForKey("archipelago") = dictionary["archipelago"]
//        
//    }
    
    
    func proposedTradeCellText() -> String {
        var pluralizeShares = "s"
        if shares == 1 {
            pluralizeShares = ""
        }
        
        return "\(archipelago!) | \(proposer) proposed \(buyOrSell.lowercaseString)ing \(shares) share\(pluralizeShares) of \(ticker) at $\(limitPrice!) per share."
    }
    
    func executeTrade() -> ExecutedTrade {
        var tradeToExecute = ExecutedTrade(proposedTrade: self)
        
        //SEND THE ORDER TO API
        tradeToExecute.dateExecuted = tradeToExecute.dateAccepted
        tradeToExecute.priceExecuted = tradeToExecute.limitPrice
        
        return tradeToExecute
    }
}


class ExecutedTrade: Serializable {
    var actionType: String
    
    //PROPOSAL Vars
    var archipelago: String?
    var archipelagoID: String?
    var proposer: String
    
    // Will use Archipelago property to calculate time left until expiration
    var dateProposed: NSTimeInterval //NSDate
    var proposalLength: Int // take this from Arch characteristics; need to think about type
    var dateExpiring: NSTimeInterval? {
        get{
            let ProposalLengthSeconds: NSTimeInterval = Double(proposalLength) * 24.0 * 60.0 * 60.0
            return dateProposed + ProposalLengthSeconds
        }
    }
    
    //Section off this "voting" behavior in the future
    var numOfArchMembers: Int
    var yesVotes: Int
    var noVotes: Int
    var pendingVotes: Int
    
    
 //ProposedTrade Vars
    var buyOrSell: String //buy or sell; make enum; potentially sub-type w/ limit vs. market or whatever
    //let orderType: orderType (enum)
    var ticker: String
    var shares: Int
    var limitPrice: NSNumber?
    
    
//ExecutedTrade Vars
    var dateAccepted: NSTimeInterval
    var dateExecuted: NSTimeInterval //HAD TO CHANGE FROM OPTIONAL FOR DICTIONARY READ
    
    var priceExecuted: NSNumber?
    
    override init(){
        actionType = "ExecutedTrade"
        
        dateAccepted = NSDate().timeIntervalSince1970
        dateExecuted = 0 //HAD TO CHANGE FROM OPTIONAL FOR DICTIONARY READ
        priceExecuted = nil
        
        buyOrSell = "Buy"
        ticker = "MSFT"
        shares = 1
        limitPrice = 0.0
        self.archipelago = ""
        self.archipelagoID = ""
        self.proposer = ""
        self.dateProposed = NSDate().timeIntervalSince1970
        self.proposalLength = 1
        self.numOfArchMembers = 0
        self.yesVotes = 0
        self.noVotes = 0
        self.pendingVotes = 0
    }
    
    init(proposedTrade: ProposedTrade){
        actionType = "ExecutedTrade"
        
        dateAccepted = NSDate().timeIntervalSince1970
        dateExecuted = 0 //HAD TO CHANGE FROM OPTIONAL FOR DICTIONARY READ
        priceExecuted = nil
        
        //super.init(archipelago: archipelago, proposal: proposal)
   
        //Proposal Properties
        self.archipelago = proposedTrade.archipelago
        self.archipelagoID = proposedTrade.archipelagoID
        self.proposer = proposedTrade.proposer
        self.dateProposed = proposedTrade.dateProposed
        self.proposalLength = proposedTrade.proposalLength
        self.numOfArchMembers = proposedTrade.numOfArchMembers
        self.yesVotes = proposedTrade.yesVotes
        self.noVotes = proposedTrade.noVotes
        self.pendingVotes = proposedTrade.pendingVotes
        
        //ProposedTrade Properties
        self.buyOrSell = proposedTrade.buyOrSell
        self.ticker = proposedTrade.ticker
        self.shares = proposedTrade.shares
        self.limitPrice = proposedTrade.limitPrice
    }
    
    
    func populateExecuTrade() {
        self.dateExecuted =  NSDate().timeIntervalSince1970 - numDaysToSeconds(2)
        self.priceExecuted = 100.00
        self.ticker = "MSFT"
        self.shares = 10
        self.buyOrSell = "Buy"
    }
}

class RejectedTrade: Serializable {
    var actionType: String
    
    //PROPOSAL Vars
    var archipelago: String?
    var archipelagoID: String?
    var proposer: String
    
    // Will use Archipelago property to calculate time left until expiration
    var dateProposed: NSTimeInterval //NSDate
    var proposalLength: Int // take this from Arch characteristics; need to think about type
    var dateExpiring: NSTimeInterval? {
        get{
            let ProposalLengthSeconds: NSTimeInterval = Double(proposalLength) * 24.0 * 60.0 * 60.0
            return dateProposed + ProposalLengthSeconds
        }
    }
    
    //Section off this "voting" behavior in the future
    var numOfArchMembers: Int
    var yesVotes: Int
    var noVotes: Int
    var pendingVotes: Int
    
    
    //PROPOSED TRADES VARS
    var buyOrSell: String //buy or sell; make enum; potentially sub-type w/ limit vs. market or whatever
    //let orderType: orderType (enum)
    var ticker: String
    var shares: Int
    var limitPrice: NSNumber? 
    
    
    
    var dateRejected: NSTimeInterval
    
    override init(){
        actionType = "RejectedTrade"
        
        dateRejected = NSDate().timeIntervalSince1970
        
        buyOrSell = "Buy"
        ticker = "MSFT"
        shares = 1
        limitPrice = 0.0
        self.archipelago = ""
        self.archipelagoID = ""
        self.proposer = ""
        self.dateProposed = NSDate().timeIntervalSince1970
        self.proposalLength = 1
        self.numOfArchMembers = 0
        self.yesVotes = 0
        self.noVotes = 0
        self.pendingVotes = 0
    }
    
    init(proposedTrade: ProposedTrade) {
        actionType = "RejectedTrade"
        
        dateRejected = NSDate().timeIntervalSince1970
    
        //super.init(archipelago: archipelago, proposal: proposal)
    
        //Proposal Properties
        self.archipelago = proposedTrade.archipelago
        self.archipelagoID = proposedTrade.archipelagoID
        self.proposer = proposedTrade.proposer
        self.dateProposed = proposedTrade.dateProposed
        self.proposalLength = proposedTrade.proposalLength
        self.numOfArchMembers = proposedTrade.numOfArchMembers
        self.yesVotes = proposedTrade.yesVotes
        self.noVotes = proposedTrade.noVotes
        self.pendingVotes = proposedTrade.pendingVotes
        
        //ProposedTrade Properties
        self.buyOrSell = proposedTrade.buyOrSell
        self.ticker = proposedTrade.ticker
        self.shares = proposedTrade.shares
        self.limitPrice = proposedTrade.limitPrice
    }
}


//var proposedTrade1 = ProposedTrade(archipelago: archipelago1, proposal: proposal)
//
//var proposedTrade2 =  ProposedTrade(archipelago: archipelago1, proposal: proposal)
//




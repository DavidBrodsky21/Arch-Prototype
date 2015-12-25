//
//  Deposits Structs.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/30/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

//DEPOSIT
class ProposedDeposit: Serializable {
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

    //DEPOSIT Vars
    var dollarAmount: Double
    var recurring: Bool?
    var recurringFrequency: String? //change to enum
    
    override init(){
        actionType = "ProposedDeposit"
        
        dollarAmount = 0
        
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
    
    init(archipelago: Archipelago, proposal: Proposal) {
        actionType = "ProposedDeposit"
        
        dollarAmount = 0.0
        recurring = false
        //super.init(archipelago: archipelago)
        
        if recurring == true {
            recurringFrequency = "Quarterly"
        }
        
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
    
    func proposedDepositCellText() -> String {
        var recurringText = "one-time"
        var frequencyText = ""
        if recurring == true {
            recurringText = "recurring"
            frequencyText = " \(recurringFrequency!)"
        }
        return "\(archipelago) | \(proposer) proposed a \(recurringText) deposit of \(dollarAmount) per person\(frequencyText)."
    }
}

class ExecutedDeposit: Serializable {
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
    
    //DEPOSIT Vars
    var dollarAmount: Double
    var recurring: Bool?
    var recurringFrequency: String? //change to enum

    
    //DepositExecuted Vars
    var dateAccepted: NSTimeInterval
    var dateExecuted: NSTimeInterval?
    
    override init(){
        actionType = "ExecutedDeposit"
        
        dollarAmount = 0
        
        dateAccepted = NSDate().timeIntervalSince1970
        dateExecuted = nil
        
        
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
    
    init(archipelago: Archipelago, proposal: Proposal, proposedDeposit: ProposedDeposit){
        actionType = "ExecutedDeposit"
        
        dateAccepted = NSDate().timeIntervalSince1970
        dateExecuted = nil
        //super.init(archipelago: archipelago, proposal: proposal)
        
        //Proposal Properties
        self.archipelago = proposedDeposit.archipelago
        self.archipelagoID = proposedDeposit.archipelagoID
        self.proposer = proposedDeposit.proposer
        self.dateProposed = proposedDeposit.dateProposed
        self.proposalLength = proposedDeposit.proposalLength
        self.numOfArchMembers = proposedDeposit.numOfArchMembers
        self.yesVotes = proposedDeposit.yesVotes
        self.noVotes = proposedDeposit.noVotes
        self.pendingVotes = proposedDeposit.pendingVotes
        
        //ProposedDeposit Properties
        self.dollarAmount = proposedDeposit.dollarAmount
        self.recurring = proposedDeposit.recurring
        self.recurringFrequency = proposedDeposit.recurringFrequency
    }
}

class RejectedDeposit: Serializable {
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
    
    //DEPOSIT Vars
    var dollarAmount: Double
    var recurring: Bool?
    var recurringFrequency: String? //change to enum

    //DepositRejected Vars
    var dateRejected: NSTimeInterval
    
    override init(){
        actionType = "RejectedDeposit"
        
        dollarAmount = 0
        
        dateRejected = NSDate().timeIntervalSince1970
        
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
    
   init(archipelago: Archipelago, proposal: Proposal, proposedDeposit: ProposedDeposit){
        actionType = "RejectedDeposit"
    
        dateRejected = NSDate().timeIntervalSince1970
        //super.init(archipelago: archipelago, proposal: proposal)
    
        //Proposal Properties
        self.archipelago = proposedDeposit.archipelago
        self.archipelagoID = proposedDeposit.archipelagoID
        self.proposer = proposedDeposit.proposer
        self.dateProposed = proposedDeposit.dateProposed
        self.proposalLength = proposedDeposit.proposalLength
        self.numOfArchMembers = proposedDeposit.numOfArchMembers
        self.yesVotes = proposedDeposit.yesVotes
        self.noVotes = proposedDeposit.noVotes
        self.pendingVotes = proposedDeposit.pendingVotes
        
        //ProposedDeposit Properties
        self.dollarAmount = proposedDeposit.dollarAmount
        self.recurring = proposedDeposit.recurring
        self.recurringFrequency = proposedDeposit.recurringFrequency
    }
}
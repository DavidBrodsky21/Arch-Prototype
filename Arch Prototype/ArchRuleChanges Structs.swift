//
//  ArchRuleChanges Structs.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/30/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

//ARCH RULE CHANGES
class ProposedArchRulesChange: Serializable {
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
    
    //ARCHRULECHANGES Vars
    var rule: String? //ArchRule class
    var newValue: String? //Enum
    
    override init(){
        actionType = "ProposedArchRulesChange"
        
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
        actionType = "ProposedArchRulesChange"
        rule = nil
        newValue = nil
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
    
    func proposedArchRuleChangesCellText() -> String {
        return "\(archipelago) | \(proposer) proposed to change \(rule) to \(newValue)."
    }
}

class ExecutedArchRulesChange: Serializable {
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
    
    //ARCHRULECHANGES Vars
    var rule: String? //ArchRule class
    var newValue: String? //Enum
    
    //EXECUTEDARCHRULESCHANGE Vars
    var dateAccepted: NSTimeInterval
    var dateExecuted: NSTimeInterval?
    
    override init(){
        actionType = "ExecutedArchRulesChange"
        
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
    
    init(archipelago: Archipelago, proposal: Proposal, proposedArchRulesChange: ProposedArchRulesChange){
        actionType = "ExecutedArchRulesChange"
        
        dateAccepted = NSDate().timeIntervalSince1970
        dateExecuted = nil
        //super.init(archipelago: archipelago, proposal: proposal)
        
        //Proposal Properties
        self.archipelago = proposedArchRulesChange.archipelago
        self.archipelagoID = proposedArchRulesChange.archipelagoID
        self.proposer = proposedArchRulesChange.proposer
        self.dateProposed = proposedArchRulesChange.dateProposed
        self.proposalLength = proposedArchRulesChange.proposalLength
        self.numOfArchMembers = proposedArchRulesChange.numOfArchMembers
        self.yesVotes = proposedArchRulesChange.yesVotes
        self.noVotes = proposedArchRulesChange.noVotes
        self.pendingVotes = proposedArchRulesChange.pendingVotes
        
        //ProposedArchRulesChange Properties
        self.rule = proposedArchRulesChange.rule
        self.newValue = proposedArchRulesChange.newValue
    }
}

class RejectedArchRulesChange: Serializable {
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
    
    //ARCHRULECHANGES Vars
    var rule: String? //ArchRule class
    var newValue: String? //Enum
    
    //ARCHRULECHANGESREJECTED Vars
    var dateRejected: NSTimeInterval
    
    override init(){
        actionType = "RejectedArchRulesChange"
        
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
    
    init(archipelago: Archipelago, proposal: Proposal, proposedArchRulesChange: ProposedArchRulesChange){
        actionType = "RejectedArchRulesChange"
        
        dateRejected = NSDate().timeIntervalSince1970
        //super.init(archipelago: archipelago, proposal: proposal)
        
        //Proposal Properties
        self.archipelago = proposedArchRulesChange.archipelago
        self.archipelagoID = proposedArchRulesChange.archipelagoID
        self.proposer = proposedArchRulesChange.proposer
        self.dateProposed = proposedArchRulesChange.dateProposed
        self.proposalLength = proposedArchRulesChange.proposalLength
        self.numOfArchMembers = proposedArchRulesChange.numOfArchMembers
        self.yesVotes = proposedArchRulesChange.yesVotes
        self.noVotes = proposedArchRulesChange.noVotes
        self.pendingVotes = proposedArchRulesChange.pendingVotes
        
        //ProposedArchRulesChange Properties
        self.rule = proposedArchRulesChange.rule
        self.newValue = proposedArchRulesChange.newValue
    }
}
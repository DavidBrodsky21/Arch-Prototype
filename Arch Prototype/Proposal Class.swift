//
//  Test.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/22/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

/*Actions:
1)  Trade - Buy/Sell
2)  Deposit
3)  Change terms

A) Pending
B) Executed
C) Rejected
*/

class Proposal: Serializable {
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
    
    init(archipelago: Archipelago){
        self.archipelago = archipelago.archName
        self.archipelagoID = archipelago.archID
        proposer = "David"
        
        dateProposed = NSDate().timeIntervalSince1970
        proposalLength = archipelago.archRules.maxDaysProposalPending
        numOfArchMembers = archipelago.members.count
        yesVotes = 0
        noVotes = 0
        pendingVotes = numOfArchMembers //REVISE
    }
    
    func toDict() -> NSDictionary {
        var dictionary = [String: AnyObject]()
//        dictionary.append("archipelago": self.archipelago])
        dictionary["archipelago"] = self.archipelago
//        dictionary.setValue(self.archipelago, forKey: archipelago)
//        dictionary.setValue(self.proposer, forKey: proposer)
        //.setValue(propValue, forKey: propName)
//        dictionary["archipelago"] = self.archipelago
//        dictionary["proposer"] = self.proposer
//        return dictionary
        return NSDictionary(dictionary: dictionary)
    }
}

//MAY WANT TO ADD CLASSES OR PROTOCOLS FOR "EXECUTED" AND/OR "REJECTED"


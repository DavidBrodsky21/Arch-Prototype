//
//  Activity Struct.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/29/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

class ActionsHistory: Serializable {
    //Trade History
    var tradeHistoryProposed: [ProposedTrade]
    var tradeHistoryExecuted: [ExecutedTrade]
    var tradeHistoryRejected: [RejectedTrade]
    
    //Deposits History
    var depositsHistoryProposed: [ProposedDeposit]
    var depositsHistoryExecuted: [ExecutedDeposit]
    var depositsHistoryRejected: [RejectedDeposit]
    
    //ArchRulesChanges History
    var archRulesChangeHistoryProposed: [ProposedArchRulesChange]
    var archRulesChangeHistoryExecuted: [ExecutedArchRulesChange]
    var archRulesChangeHistoryRejected: [RejectedArchRulesChange]
       
//    var depositsHistory: [String: [ProposedDeposit]]
//    var archRulesChangeHistory: [String: [ProposedArchRulesChange]] //date: string description of what happened to ArchRules (consider auto updating with method in the ArchRules struct
//    
    //THINK ABOUT THIS DATE STUFF
    var memberHistory: [NSTimeInterval: String]? //date accepted invite: Name
    
    init(dateOfCreation: NSTimeInterval, archCreatorID: String? ){
        //Trade History
        tradeHistoryProposed = []
        tradeHistoryExecuted = []
        tradeHistoryRejected = []
        
        //Deposits History
        depositsHistoryProposed = []
        depositsHistoryExecuted = []
        depositsHistoryRejected = []
        
        //ArchRulesChanges History
        archRulesChangeHistoryProposed = []
        archRulesChangeHistoryExecuted = []
        archRulesChangeHistoryRejected = []
        
        if let archCreatorIDUnwrapped = archCreatorID {
            memberHistory = [dateOfCreation: archCreatorIDUnwrapped]
        }
    }
    
    func clearActionsHistory() {
        //Trade History
        tradeHistoryProposed = []
        tradeHistoryExecuted = []
        tradeHistoryRejected = []
        
        //Deposits History
        depositsHistoryProposed = []
        depositsHistoryExecuted = []
        depositsHistoryRejected = []
    }
}






//OLD INITIALIZER
        //        tradeHistory = ["Proposed": [ProposedTrade](), "Executed": [ExecutedTrade](), "Rejected": [RejectedTrade]()]
        //        depositsHistory = ["Proposed": [ProposedDeposit](), "Executed": [ExecutedDeposit](), "Rejected": [RejectedDeposit]()]
        //        archRulesChangeHistory = ["Proposed": [ProposedArchRulesChange](), "Executed": [ExecutedArchRulesChange](), "Rejected": [RejectedArchRulesChange]()]
    
    
//    func getActionHistoryDict() -> [String: AnyObject]? {
//        var tradeHistoryProposedDict = [[String: AnyObject]]()
//        for index in 0..<tradeHistoryProposed.count {
//            if let objectDictionary = objectToDictionary(tradeHistoryProposed[index]) {
//                tradeHistoryProposedDict.append(objectDictionary)
//            }
//        }
//
//        var actionHistoryDict = ["tradeHistoryProposed": tradeHistoryProposedDict]
//        return actionHistoryDict
//    }



//class ActionsHistory: Serializable {
//    var tradeHistory: [String: [ProposedTrade]]
//    var depositsHistory: [String: [ProposedDeposit]]
//    var archRulesChangeHistory: [String: [ProposedArchRulesChange]] //date: string description of what happened to ArchRules (consider auto updating with method in the ArchRules struct
//    
//    //THINK ABOUT THIS DATE STUFF
//    var memberHistory: [NSTimeInterval: String]? //date accepted invite: Name
//    
//    init(dateOfCreation: NSTimeInterval, archCreatorID: String? ){
//        tradeHistory = ["Proposed": [ProposedTrade](), "Executed": [ExecutedTrade](), "Rejected": [RejectedTrade]()]
//        depositsHistory = ["Proposed": [ProposedDeposit](), "Executed": [ExecutedDeposit](), "Rejected": [RejectedDeposit]()]
//        archRulesChangeHistory = ["Proposed": [ProposedArchRulesChange](), "Executed": [ExecutedArchRulesChange](), "Rejected": [RejectedArchRulesChange]()]
//        if let archCreatorIDUnwrapped = archCreatorID {
//            memberHistory = [dateOfCreation: archCreatorIDUnwrapped]
//        }
//    }
//}

//class ActionsHistory: Serializable {
//    var tradeHistory: [String: [String]]
//    var depositsHistory: [String: [String]]
//    var archRulesChangeHistory: [String: [String]] //date: string description of what happened to ArchRules (consider auto updating with method in the ArchRules struct
//    
//    //THINK ABOUT THIS DATE STUFF
//    var memberHistory: [NSTimeInterval: String]? //date accepted invite: Name
//    
//    init(dateOfCreation: NSTimeInterval, archCreatorID: String? ){
//        tradeHistory = ["Proposed": ["blah"], "Executed": ["blah"], "Rejected": []]
//        depositsHistory = ["Proposed": [], "Executed": [], "Rejected": []]
//        archRulesChangeHistory = ["Proposed": [], "Executed": [], "Rejected": []]
//        if let archCreatorIDUnwrapped = archCreatorID {
//            memberHistory = [dateOfCreation: archCreatorIDUnwrapped]
//        }
//    }
//}

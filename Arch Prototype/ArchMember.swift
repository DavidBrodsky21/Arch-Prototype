//
//  ArchMember.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/29/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

//OLD IMPLEMENTATION AS SUBCLASS NO LONGER USED

import Foundation


class ArchMember {
    var userID: String?
    var originalMember: Bool? //whether a user was a member at arch creation or was invited later
    var dateAcceptedInvite: NSDate? //FIGURE OUT DATE VARS NSDATE?
    var originalContribution: Double? //ADJUST TO ACCOUNT FOR ADDITIONAL DEPOSITS
    var totalContribution: Double? //pct owned (below) is not just totalContrib(member) / totalContrib(Arch);  Think about asset appreciation and timing of extra deposits.
    // May want some sort of dictionary capturing all contributions and their dates
    var pctOfArchOwned: Double? //should be calculated or based on a function
    
    init(userID: String?){
        self.userID = userID
        //originalMember = true
        //dateAcceptedInvite =
        originalContribution = 0.0
        totalContribution = 0.0
        pctOfArchOwned = 0.0
    }
}

//
//class ArchMember : Friend {
//    let originalMember: Bool //whether a user was a member at arch creation or was invited later
//    let dateAcceptedInvite: String //FIGURE OUT DATE VARS NSDATE?
//    let originalContribution: Double //ADJUST TO ACCOUNT FOR ADDITIONAL DEPOSITS
//    let totalContribution: Double //pct owned (below) is not just totalContrib(member) / totalContrib(Arch);  Thing about asset appreciation and timing of extra deposits.
//    // May want some sort of dictionary capturing all contributions and their dates
//    var pctOfArchOwned: Double //should be calculated or based on a function
//    
//    override init(){
//        originalMember = true
//        dateAcceptedInvite = ""
//        originalContribution = 0.0
//        totalContribution = 0.0
//        pctOfArchOwned = 0.0
//        super.init()
//    }
//}
//
//  FriendClass.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/29/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

class Friend {
    let firstName: String?
    let lastName: String?
    let fullName: String?
    
    let userName: String?
    
    var emailAddress: String?
    
    private let userID: Int? //userID for internal app purposes
    
    var archipelagosJoined: [([Int : String], Int)] //Archipelagos of which you've been a member, (archID: ArchName, Active?)
    
    
    init(){
        firstName = ""
        lastName = ""
        fullName = firstName! + " " + lastName!
        
        userName = ""
        
        emailAddress = ""
        
        userID = 0
        
        archipelagosJoined = [([1: "Arch1"], 1), ([2: "Arch2"], 0)] //REMEMBER TO UPDATE
    }
    
}




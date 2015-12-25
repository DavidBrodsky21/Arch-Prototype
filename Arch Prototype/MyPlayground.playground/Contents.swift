////: Playground - noun: a place where people can play
//
//import UIKit
//
////
////  ArchipelagoStruct.swift
////  Arch Prototype
////
////  Created by David Brodsky on 7/25/15.
////  Copyright (c) 2015 Arch Developers. All rights reserved.
////
//
import Foundation
//
//
//class Friend {
//    let firstName: String?
//    let lastName: String?
//    let fullName: String?
//    
//    let userName: String?
//    
//    var emailAddress: String?
//    
//    private let userID: Int? //userID for internal app purposes
//    
//    var archipelagosJoined: [([Int : String], Int)] //Archipelagos of which you've been a member, (archID: ArchName, Active?)
//    
//    
//    init(){
//        firstName = "bob"
//        lastName = ""
//        fullName = firstName! + " " + lastName!
//        
//        userName = ""
//        
//        emailAddress = ""
//        
//        userID = 0
//        
//        archipelagosJoined = [([1: "Arch1"], 1), ([2: "Arch2"], 0)] //REMEMBER TO UPDATE
//    }
//    
//}
//
//struct Archipelago {
//    var status: String //enum?
//    var invites: [String: [Friend]] // (Friend, status); status should be enum? who has been invited or invited and outstanding?
//    var assets: [String] //[Asset] // Need to create Asset class
//    var originalMoneyInvested: Double //maybe should be calculated, maybe need other things like this
//   // var members: [ArchMember]
//    var activity: [String] //[Activity] //Need to create Activity class
//    var archRules: [String]//ArchRules //Not array right?
//    //    var chat: [String] //PROBABLY WILL NEED TO CHANGE
//    var depositSchedule: Int //Enum fo sho
//    
//    init(friendsInvited: [Friend]){
//        status = "Pending"
//        //self.invites = [(friendsInvited[0], "Accepted"), (friendsInvited[1], "Pending")]
//        self.invites = ["Pending": friendsInvited, "Accepted": []]
//        assets = []
//        originalMoneyInvested = 0
//       // members = []
//        activity = ["Archipelago Initiated, Invites Sent!"] //Need to create Activity class
//        archRules = ["Default"] //ArchRules //Initiate to some default?
//        //        chat: [String] //PROBABLY WILL NEED TO CHANGE
//        depositSchedule = 1
//    }
//}
//
//let friend1 = Friend()
//let archipelago1 = Archipelago(friendsInvited: [friend1])
//
//
//let new = archipelago1.invites["Pending"]
//let newNew = new?[0].fullName
//
//
//
//
//

//
//struct User {
//    var firstName: String?
//    var lastName: String?
//    var fullName: String? {
//        get{
//            return firstName! + " " + lastName!
//        }
//        set{
//            var substring = newValue?.componentsSeparatedByString(" ")
//            firstName = substring![0]
//            lastName = substring![substring!.count-1]
//        }
//    }
//    let userName: String?
//    var password: String?
//    
//    var emailAddress: String?
//    
//    var settings: [String: AnyObject]?
//    
//    private let userID: Int? //userID for internal app purposes
//    
//    var archipelagosJoined: [([Int : String], Int)] //Archipelagos of which you've been a member, (archID: ArchName, Active?)
//    
//    init(){
//        firstName = "James"
//        lastName = "Beard"
//        //fullName = firstName! + " " + lastName!
//        
//        userName = ""
//        password = ""
//        
//        emailAddress = ""
//        
//        settings = ["setting1": "blah"]
//        
//        userID = 0
//        
//        archipelagosJoined = [([1: "Arch1"], 1), ([2: "Arch2"], 0)] //REMEMBER TO UPDATE
//    }
//    
//}
//
//var new = User()
//
////new.fullName =
//
//new.fullName = "Riso blah eimn Al"
//new.firstName
//
//new.lastName
//
////
////
////


//var date = NSDateComponents()

//date.description


let dailyChangeDollarVal = "+1.54"

let sign = dailyChangeDollarVal[dailyChangeDollarVal.startIndex]

var dictionary = [String: AnyObject]()
dictionary["new"] = "Blah"

//        dictionary.append("archipelago": self.archipelago])
//dictionary.setValue("blah", forKey: "archipelago")
dictionary




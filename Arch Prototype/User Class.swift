//
//  UserStruct.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/29/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

class User: Serializable {
    var firstName: String?
    var lastName: String?
    var fullName: String? {
        get{
            return firstName! + " " + lastName!
        }
        set{
            var substring = newValue?.componentsSeparatedByString(" ")
            firstName = substring![0]
            lastName = substring![substring!.count-1]
        }
    }
    
    var emailAddress: String?
    var userName: String?
    var password: String?
    
    var settings: [String: AnyObject]?
    
    var userID: String? //userID for internal app purposes
    
    var pendingInvites: [String]? //for now: ArchID of archs currently invited to (and pending); eventually other sort of non-arch specific invites/proposal, e.g. to follow/compete with another arch
    
    var archipelagosJoined: [String] //ArchID
    //[Int: [String: Int]]? //Archipelagos of which you've been a member, [archID: [ArchName, Active?] ]
    
    override init(){
        archipelagosJoined = []
    }
    //DELETE INIT?
    init(firstName: String, lastName: String, emailAddress: String, username: String, password: String?){
        self.firstName = firstName
        self.lastName = lastName
        self.emailAddress = emailAddress
        self.userName = username
        self.password = password
        
        archipelagosJoined = []
    }
    
    init(userID: String){
        self.userID = userID
        self.archipelagosJoined = []
    }
    

//    
//    init(userID: String, ReadFromFirebase: Bool){
//        self.userID = userID
//        self.firstName = nil
//        
//        super.init()
//        
//        var RefPath = FirebaseRef.childByAppendingPath("users/\(self.userID!)")
//        RefPath.observeEventType(.Value, withBlock: {
//            snapshot in
//            var userDict: NSDictionary = snapshot.value as! NSDictionary
//      
//                if let firstNameR = userDict["firstName"] as? String {
//                    self.firstName = firstNameR
//                }
//                
////                if let lastName = userDict["lastName"] as? String {
////                    self.lastName = lastName
////                }
////                
////                if let emailAddress = userDict["emailAddress"] as? String {
////                    self.emailAddress = emailAddress
////                }
////                
////                if let userName = userDict["userName"] as? String {
////                    self.userName = userName
////                }
////                if let password = userDict["password"] as? String {
////                    self.password = password
////                }
////                
////                if let settings = userDict["settings"] as? [String: AnyObject]? {
////                    self.settings = settings
////                }
////                
////                if let pendingInvites = userDict["pendingInvites"] as? [String] {
////                    self.pendingInvites = pendingInvites
////                }
////                
////                if let archipelagosJoined = userDict["archipelagosJoined"] as? [String]  {
////                    self.archipelagosJoined = archipelagosJoined
////                }
//            
//            //self.user = userFromDictionary(userDict)
//        })
//    }
    
//    func readFirebaseUserInfo(#userID: String) {
//        var RefPath = FirebaseRef.childByAppendingPath("users/\(userID)")
//        RefPath.observeEventType(.Value, withBlock: {
//            snapshot in
//            var userDict: NSDictionary = snapshot.value as! NSDictionary
//            
//            
//            //self.user = userFromDictionary(userDict)
//        })
//    }

    
//FIREBASE FUNCTIONS
    
//Write Functions
    func writeNewUserToFirebase(userID userID: String){
        let writeValue = self.toDictionary()
        //let writeValue = self.userToDictionary()
        // Write data to Firebase
        let usersRef = FirebaseRef.childByAppendingPath("users/\(userID)")
        usersRef.setValue(writeValue)
        print("writebutton clicked", terminator: "")
    }
    
    func updateUserInFirebase(){
        let writeValue = self.toDictionary()
        let usersRef = FirebaseRef.childByAppendingPath("users/\(self.userID!)")
        usersRef.setValue(writeValue)
    }
    
    func updateUserPropertyInFirebase(property: String){
        let userDict = self.toDictionary()
        let writeValue: AnyObject? = userDict[property]
        let usersRef = FirebaseRef.childByAppendingPath("users/\(self.userID!)/\(property)")
        usersRef.setValue(writeValue)
    }
    
//Read Functions
    func userPropertiesFromDictionary(dictionary: NSDictionary) {
        if let firstName = dictionary["firstName"] as? String {
            self.firstName = firstName
        }
        
        if let lastName = dictionary["lastName"] as? String {
            self.lastName = lastName
        }
        
        if let emailAddress = dictionary["emailAddress"] as? String {
            self.emailAddress = emailAddress
        }
        
        if let userName = dictionary["userName"] as? String {
            self.userName = userName
        }
        if let password = dictionary["password"] as? String {
            self.password = password
        }
        
        if let settings = dictionary["settings"] as? [String: AnyObject]? {
            self.settings = settings
        }
        
        if let pendingInvites = dictionary["pendingInvites"] as? [String] {
            self.pendingInvites = pendingInvites
        }
        
        if let archipelagosJoined = dictionary["archipelagosJoined"] as? [String]  {
            self.archipelagosJoined = archipelagosJoined
        }
    }

}

/* 
    
//            //NEED TO ACTUALLY WRITE userPropertyFromDictionary Function; 
//            //Next steps:
//            // 2) create this userPropertyFromFirebase function
//            // 3) see if we can take the "createUserFromFirebase" func on masterViewController and generalize it.
//
    func readUserPropertyFromFirebase(property: String) {
        var RefPath = FirebaseRef.childByAppendingPath("users/\(self.userID!)")
        println("The RefPath is: \(RefPath!).")
            
        RefPath.observeEventType(.Value, withBlock: {
            snapshot in
            var propertyDict: NSDictionary = snapshot.value as! NSDictionary
            
            var userInfo = userFromDictionary(propertyDict)
            var propertyInfo: AnyObject? = userInfo!.valueForKey(property)
            self.setValue(propertyInfo, forKey: property)
        })
    }
    
    
    func propertyFromDictionary(dictionary: NSDictionary) -> User? {
        if let userID = dictionary["userID"] as? String {
            var user: User = User(userID: userID)
            
            if let firstName = dictionary["firstName"] as? String {
                user.firstName = firstName
            }
            
            if let lastName = dictionary["lastName"] as? String {
                user.lastName = lastName
            }
            
            if let emailAddress = dictionary["emailAddress"] as? String {
                user.emailAddress = emailAddress
            }
            
            if let userName = dictionary["userName"] as? String {
                user.userName = userName
            }
            if let password = dictionary["password"] as? String {
                user.password = password
            }
            
            if let settings = dictionary["settings"] as? [String: AnyObject]? {
                user.settings = settings
            }
            
            if let pendingInvites = dictionary["pendingInvites"] as? [String] {
                user.pendingInvites = pendingInvites
            }
            
            if let archipelagosJoined = dictionary["archipelagosJoined"] as? [String]  {
                user.archipelagosJoined = archipelagosJoined
            }
            
            return user
        }
        else {
            return nil
        }
    }
//Firebase helper functions
//    func userToDictionary() -> [String: AnyObject] {
//        var userAsDictionary: [String: AnyObject] =
//        [
//            "firstName": firstName!,
//            "lastName": lastName!,
//            "fullName": fullName!,
//            "emailAddress": emailAddress!,
//            "userName": userName!,
//            "password": password!,
//            //"settings": settings,
//            "userID": userID!,
//            "archipelagosJoined": archipelagosJoined!
//        ]
//        return userAsDictionary
//    }

    
    func readFirebaseUserInfo() {
        var RefPath = FirebaseRef.childByAppendingPath("users/\(self.userID!)")
        //println("RefPath is: \(RefPath)")
        var completed: Bool = false
        RefPath.observeEventType(.Value, withBlock: {
            snapshot in
            var userDict: NSDictionary = snapshot.value /*exists*/ as! NSDictionary
            //self = userFromDictionary(userDict)
            
//            if let userID = dictionary["userID"] as? String {
//                var user: User = User(userID: userID)
            
                if let firstName = userDict["firstName"] as? String {
                    self.firstName = firstName
                }
                
                if let lastName = userDict["lastName"] as? String {
                    self.lastName = lastName
                }
                
                if let emailAddress = userDict["emailAddress"] as? String {
                    self.emailAddress = emailAddress
                }
                
                if let userName = userDict["userName"] as? String {
                    self.userName = userName
                }
                if let password = userDict["password"] as? String {
                    self.password = password
                }
                
                if let settings = userDict["settings"] as? [String: AnyObject]? {
                    self.settings = settings
                }
            
                if let pendingInvites = userDict["pendingInvites"] as? [String] {
                    self.pendingInvites = pendingInvites
                }
                
                if let archipelagosJoined = userDict["archipelagosJoined"] as? [String]  {
                    self.archipelagosJoined = archipelagosJoined
                }
            println("inside firebase func; complete")
            println("firstName in here = \(self.firstName)")
        })
    }

}

func userFromDictionary(dictionary: NSDictionary) -> User? {
    if let userID = dictionary["userID"] as? String {
        var user: User = User(userID: userID)
    
        if let firstName = dictionary["firstName"] as? String {
            user.firstName = firstName
        }
        
        if let lastName = dictionary["lastName"] as? String {
            user.lastName = lastName
        }
        
        if let emailAddress = dictionary["emailAddress"] as? String {
            user.emailAddress = emailAddress
        }
        
        if let userName = dictionary["userName"] as? String {
            user.userName = userName
        }
        if let password = dictionary["password"] as? String {
            user.password = password
        }
        
        if let settings = dictionary["settings"] as? [String: AnyObject]? {
            user.settings = settings
        }
        
        if let pendingInvites = dictionary["pendingInvites"] as? [String] {
            user.pendingInvites = pendingInvites
        }
        
        if let archipelagosJoined = dictionary["archipelagosJoined"] as? [String]  {
            user.archipelagosJoined = archipelagosJoined
        }
        
        return user
    }
    else {
        println("ERROR Reading in User")
        return nil
    }
}

*/



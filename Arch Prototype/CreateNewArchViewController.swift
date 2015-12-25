//
//  CreateNewArchViewController.swift
//  Arch Prototype
//
//  Created by David Brodsky on 8/4/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import UIKit

class CreateNewArchViewController: UIViewController {
    var user: User?
    let newArch = Archipelago(friendsInvited: [])

    @IBOutlet weak var archNameLabel: UITextField?
    @IBOutlet weak var archMembersLabel: UITextField?
    @IBOutlet weak var archMinContributionLabel: UITextField?
    @IBOutlet weak var archMessageLabel: UITextField?
    
    @IBAction func sendArchInviteButton(sender: UIButton) {
//NEED TO ACCOUNT FOR NO INTERNET CONNECTION - currently dismisses viewcontroller as if nothing's wrong
        readUserInput()
        newArch.writeNewArch()
        newArch.writeArch() //To update the archID that's stored
        
        print("first block: ")
        if let newArchId = newArch.archID {
            print("Printing user.archipelagosJoined")
            print(user!.archipelagosJoined.description)
            user!.archipelagosJoined.append(newArchId)
            print("Doing it again: \(user!.archipelagosJoined.description)")
            user!.updateUserInFirebase()
        }
        
        print("second block: ")
//Fix to handle multiple users
        if archMembersLabel?.text != "" {
            if let membersInvited = archMembersLabel?.text {
                let memberUser = User(userID: membersInvited) //Currently only 1 member
                
                /*Starting firebasefunc*/
                let RefPath = FirebaseRef.childByAppendingPath("users/\(memberUser.userID!)")
    //IMPORTANT: note single event observation, think through implications.
                RefPath.observeSingleEventOfType(.Value, withBlock: {
                    snapshot in
                    let userDict: NSDictionary = snapshot.value as! NSDictionary
                    
                    //Start Dictionary to user
                    memberUser.userPropertiesFromDictionary(userDict)
                    //End dictionary to user
                    
                    if memberUser.pendingInvites != nil {
                        memberUser.pendingInvites?.append(self.newArch.archID!) //= ["arch1", "Arch2"] //newArch.archID
                        print(memberUser.pendingInvites?.description)
                    } else {
                        memberUser.pendingInvites = [self.newArch.archID!]
                        print(memberUser.pendingInvites?.description)
                    }
                    
                    memberUser.updateUserPropertyInFirebase("pendingInvites")
                })
            }
        }

        
        self.dismissViewControllerAnimated(true, completion: nil)
        

        
        
//FUNCTIONS TO BE IMPLEMENTED
        //create what invite would look like
        //send invites
        //upload proposal to firebase
        //upload invites to firebase
        
        
    }
    
//STILL NEED TO ADD OTHER FIELDS + HANDLE MEMBER BEHAVIOR
    func readUserInput(){
        if let archCreatorID = user?.userID {
            newArch.archCreatorID = archCreatorID
            newArch.invites["Accepted"] = [archCreatorID]
            newArch.members = [archCreatorID]
        }
        newArch.archName = archNameLabel?.text
        //UPDATE member getting behavior; currently will only take 1 userID a la simplelogin:21;
        if archMembersLabel?.text != "" {
            if let archMembersArray = archMembersLabel?.text {
                newArch.invites["Pending"] = [archMembersArray]
            }
        }
        if let minContribString = archMinContributionLabel?.text {
            newArch.archRules.minInvestment = (minContribString as NSString).doubleValue
        } else {
            newArch.archRules.minInvestment = 100
        }
        if let commentsAtInception = archMessageLabel?.text {
            newArch.archRules.commentsAtInception = commentsAtInception
        }
        
    }
    
//    @IBAction func saveArchButton(sender: UIButton) {
//        newArch.writeArch()
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        archNameLabel?.text = "\(user!.fullName!)'s Archipelago"
        archMembersLabel?.placeholder = "Add New Members by Username"
        archMinContributionLabel?.placeholder = "$100 (Default)"
        archMessageLabel?.placeholder = "Enter short description of Archipelago's investment strategy"
        // Do any additional setup after loading the view.
        
//        //Looks for single or multiple taps.
//        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
//        view.addGestureRecognizer(tap)
    }
    
//    //Calls this function when the tap is recognized.
//    func DismissKeyboard(){
//         println("clicked out")
//        //Causes the view (or one of its embedded text fields) to resign the first responder status.
//        view.endEditing(true)
//        println("clicked out")
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent?) {
//        view.endEditing(true)
//        println("TouchEnd")
//        super.touchesBegan(touches, withEvent: event!)
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - Table View
//    @IBOutlet weak var membersTableView: UITableView!
//    var members: [String] = ["Member1", "Bob"]
////    func change(){
////        membersTableView.
////    }
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return members.count
//    }
//    
//    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        return "Members"
//    }
//    
//    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        var dataStruct = members
//        println(user?.archipelagosJoined)
//
//        
//        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! UITableViewCell
//        //        let object = pendingProposals[indexPath.row]
//        let object = dataStruct[indexPath.row]
//        cell.textLabel!.text = object
//        
//        return cell
//    }
//    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }

    

}

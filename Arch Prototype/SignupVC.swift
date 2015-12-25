//
//  SignupVC.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/31/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation
import UIKit
import Firebase

//var FirebaseRef = Firebase(url:"https://dazzling-fire-6648.firebaseio.com") //Declared in LoginVC

class SignupVC: UIViewController {
    
    @IBOutlet weak var txtFirstName: UITextField?
    @IBOutlet weak var txtLastName: UITextField?
    @IBOutlet weak var txtEmailAddress: UITextField?
    @IBOutlet weak var txtPassword: UITextField?
    @IBOutlet weak var txtConfirmPassword: UITextField?
    
    @IBOutlet weak var txtTestText: UITextField?
    
    

    
 
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // #pragma mark - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue?, sender: AnyObject?) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func gotoLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func signupTapped(sender: UIButton) {
        //DB EDITS
                
        if let firstName = txtFirstName?.text,
            let lastName = txtLastName?.text,
            let emailAddress = txtEmailAddress?.text,
            let password = txtPassword?.text,
            let confirm_password = txtConfirmPassword?.text {
                if (firstName == "" || lastName == "" || emailAddress == "" || password == "") {
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign Up Failed!"
                    alertView.message = "Please fill out ALL fields"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                } else if ( !password.isEqual(confirm_password) ) {
                    
                    let alertView:UIAlertView = UIAlertView()
                    alertView.title = "Sign Up Failed!"
                    alertView.message = "Passwords Do Not Match"
                    alertView.delegate = self
                    alertView.addButtonWithTitle("OK")
                    alertView.show()
                } else {
                    let user = User(firstName: firstName, lastName: lastName, emailAddress: emailAddress, username: emailAddress, password: password)
                    
                    FirebaseRef.createUser(user.emailAddress, password: user.password,
                        withValueCompletionBlock: { error, result in
                            
                            if error != nil {
                                print(error)
                            } else {
                                if let uid = result["uid"] as? String {
                                    print("Successfully created user account with uid: \(uid)")
                                    
                                    user.userID = uid
                                    
                                    //var userArray = user.userToDictionary()
                                    //var userID = uid
                                    
                                    user.writeNewUserToFirebase(userID: user.userID!)
                                    
                                    
                                    print(user.userID)
                                    
                                    self.dismissViewControllerAnimated(true, completion: nil)
                                }
                            }
                    })
                    
                    //read()
                }
        }
    }
    
//    func setTestText() -> Void {
//        txtTestText?.text = new
//    }

    
        /*
            let post:NSString = "username=\(username)&password=\(password)&c_password=\(confirm_password)"
            
            NSLog("PostData: %@",post);
            
            let url:NSURL = NSURL(string: "https://dipinkrishna.com/jsonsignup.php")!
            
            let postData:NSData = post.dataUsingEncoding(NSASCIIStringEncoding)!
            
            let postLength:NSString = String( postData.length )
            
            let request:NSMutableURLRequest = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            request.HTTPBody = postData
            request.setValue(postLength as String, forHTTPHeaderField: "Content-Length")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.setValue("application/json", forHTTPHeaderField: "Accept")
            
            
            var reponseError: NSError?
            var response: NSURLResponse?
            
            var urlData: NSData?
            do {
            urlData = try NSURLConnection.sendSynchronousRequest(request, returningResponse:&response)
            } catch let error as NSError {
            reponseError = error
            urlData = nil
            }
            
            if ( urlData != nil ) {
            let res = response as! NSHTTPURLResponse!;
            
            NSLog("Response code: %ld", res.statusCode);
            
            if (res.statusCode >= 200 && res.statusCode < 300)
            {
            let responseData:NSString  = NSString(data:urlData!, encoding:NSUTF8StringEncoding)!
            
            NSLog("Response ==> %@", responseData);
            
            //var error: NSError?
            
            let jsonData:NSDictionary = try NSJSONSerialization.JSONObjectWithData(urlData!, options:NSJSONReadingOptions.MutableContainers ) as! NSDictionary
            
            
            let success:NSInteger = jsonData.valueForKey("success") as! NSInteger
            
            //[jsonData[@"success"] integerValue];
            
            NSLog("Success: %ld", success);
            
            if(success == 1)
            {
            NSLog("Sign Up SUCCESS");
            self.dismissViewControllerAnimated(true, completion: nil)
            } else {
            var error_msg:NSString
            
            if jsonData["error_message"] as? NSString != nil {
            error_msg = jsonData["error_message"] as! NSString
            } else {
            error_msg = "Unknown Error"
            }
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = error_msg as String
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            
            }
            
            } else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign Up Failed!"
            alertView.message = "Connection Failed"
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            }
            }  else {
            let alertView:UIAlertView = UIAlertView()
            alertView.title = "Sign in Failed!"
            alertView.message = "Connection Failure"
            if let error = reponseError {
            alertView.message = (error.localizedDescription)
            }
            alertView.delegate = self
            alertView.addButtonWithTitle("OK")
            alertView.show()
            }
            } catch {
                let alertView:UIAlertView = UIAlertView()
                alertView.title = "Sign Up Failed!"
                alertView.message = "Server Error!"
                alertView.delegate = self
                alertView.addButtonWithTitle("OK")
                alertView.show()
            }
        }
        
    }
    */
            
    func textFieldShouldReturn(textField: UITextField!) -> Bool {   //delegate method
        textField.resignFirstResponder()
        return true
    }
}






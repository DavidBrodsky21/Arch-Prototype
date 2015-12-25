//
//  PendingProposalViewController.swift
//  Arch Prototype
//
//  Created by David Brodsky on 9/1/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import UIKit

class PendingProposalViewController: UIViewController {
    
    
    @IBOutlet weak var pendingProposalLabel: UILabel!
    
    var pendingProposalString: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.pendingProposalLabel.text = self.pendingProposalString
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

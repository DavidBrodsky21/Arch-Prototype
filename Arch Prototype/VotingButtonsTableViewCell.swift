//
//  VotingButtonsTableViewCell.swift
//  Arch Prototype
//
//  Created by David Brodsky on 8/31/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import UIKit

class VotingButtonsTableViewCell: UITableViewCell {
    
//    @IBOutlet weak var proposalTextLabel: UILabel!
    @IBOutlet weak var proposalTextLabel: UILabel?

    @IBOutlet weak var approveButton: UIButton?
    @IBOutlet weak var rejectButton: UIButton?

//    @IBAction func approveButton(sender: UIButton) {
//        println("button pressed (approve)")
//    }
//    
//    @IBAction func rejectButton(sender: UIButton) {
//        println("button pressed (reject)")
//    }
    
   
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        proposalTextLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 13.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

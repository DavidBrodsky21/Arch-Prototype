//
//  MasterViewController.swift
//  Arch Prototype
//
//  Created by David Brodsky on 7/21/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import UIKit
import Firebase

class MasterViewController: UITableViewController {
    var dataLoaded: Bool = false
    
    var user: User?
    var archipelagoIDs = [String]()
    var archipelagoArray = [Archipelago]()
    
    var pendingProposals = [AnyObject]()
    var pendingProposalsCellText = [String]() //= [proposedTrade1.proposedTradeCellText(), proposedTrade2.proposedTradeCellText()]
    var pendingProposalsIndexes = [(String, Int)]() //(ArchID, pendingActionIndex)
    
    var pendingArchInvites = [String]()
    var pendingArchipelagosArray = [Archipelago]()
    
    /*TEMP*/
//    var newPosition = StockPosition (ticker: "MSFT", shares: 5, originalPurchasePrice: 35.00, goGetQuote: true)
//    var newPosition2 = StockPosition(ticker: "AAPL", shares: 10, originalPurchasePrice: 115.00, goGetQuote: true)
    
    // REMEMBER TO USE: self.tableView.reloadData() 
    
    @IBOutlet weak var LabelTest: UILabel?
    @IBOutlet weak var LabelTest1: UILabel?
    @IBAction func writeButton() {
       // write()
//        println("ButtonTry: ")
//        let userDictionary = user?.toDictionary()
//        userDictionary?.description
//        println(userDictionary?.description)
        
//        println("newUser Archipelagos are : ")
//        println(user?.archipelagosJoined)
        
//        println("NewPosition:")
//        println("current price = \(newPosition.stockQuote?.lastTradePrice)")
//        println("ticker = \(newPosition.ticker)")
        
//        print("limitPrice in pendingActions")
//        //let pendingActs = archipelagoArray[0].pendingActions[0] as? ProposedTrade
//        //print(pendingActs?.limitPrice)
//        
//        print("")
//        if let actionsHistoryTrade = archipelagoArray[0].actionsHistory?.tradeHistoryProposed[0] as ProposedTrade? {
//            print(actionsHistoryTrade.ticker)
//        }

    }
    
    @IBAction func newArchButton(sender: UIButton) {
        performSegueWithIdentifier("createNewArchSegue", sender: self)
    }
    
    @IBAction func buyButton(sender: UIButton) {
        performSegueWithIdentifier("buySegue", sender: self)
    }
    
    @IBAction func sellButton(sender: UIButton) {
        performSegueWithIdentifier("sellSegue", sender: self)
    }
   
    //Labels
    @IBOutlet weak var totalInvestedLabel: UILabel!
    @IBOutlet weak var todaysChangeLabel: UILabel!
    @IBOutlet weak var availableFundsLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        
        //Set arrays that may have been refreshed to empty
        archipelagoIDs = []
        archipelagoArray = []
        
        //Load Archipelagos that user is a member of
        archipelagoIDs += user!.archipelagosJoined
        
        for indexNum in 0..<archipelagoIDs.count {
            archipelagoArray.append(Archipelago())
            archipelagoArray[indexNum].archID = archipelagoIDs[indexNum]
            

            archipelagoArray[indexNum].readArchFromFirebase(tableViewToReload: self.tableView, viewController: self)
        }
        //load Archipelagos end
        
        if let pendingArchInvitesUnwrap = user?.pendingInvites {
            pendingArchInvites = pendingArchInvitesUnwrap
            
            for indexNum in 0..<pendingArchInvites.count {
                pendingArchipelagosArray.append(Archipelago())
                pendingArchipelagosArray[indexNum].archID = pendingArchInvites[indexNum]
                
                
                pendingArchipelagosArray[indexNum].readArchFromFirebase(tableViewToReload: self.tableView, viewController: self)
            }
        }
        
        
        
        
        //newPosition.getCurrentPrice()
        
//        println("In viewDidLoad, right after newPosition.getCurrentPrice()")
//        println("newPosition.stockQuote?.previousClose is: \(newPosition.stockQuote?.previousClose))")
        
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        
//        
//        var tickers = ["VZ","GOOG"]
//        var stockQuotesDictionaries = [[String: AnyObject]?]()
//        var stockQuotesArray = [StockQuote]()
//        
//        for indexNum in 0..<tickers.count {
//            stockQuotesDictionaries.insert(getQuotesDictionary(tickers, indexNum), atIndex: indexNum)
//            stockQuotesArray.insert(StockQuote(stockQuoteDict: stockQuotesDictionaries[indexNum]!), atIndex: indexNum)
//        }
//       // LabelTest?.text = archipelago1.invites.indexForKey("Pending")
//        //LabelTest?.text = userUID
//        LabelTest1?.text = stockQuotesArray[1].ticker
        
         configureTableView()
        }
    
    func configureTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 110.0
    }
    
    override func viewDidAppear(animated: Bool) {
        self.viewDidLoad()
        //self.tableView.reloadData()
        //configureTableView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

//    func insertNewObject(sender: AnyObject) {
//        pendingProposals.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }

    // MARK: - Segues
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if segue.identifier == "createNewArchSegue" {
            if let userVal = user {
                let createNewArchViewController = (segue.destinationViewController as! CreateNewArchViewController)
                createNewArchViewController.user = userVal
            }
        }
        else if segue.identifier == "PortfolioSegue" {
            let portfolioViewController = (segue.destinationViewController as! PortfolioViewController)
//TEMP
            //archipelagoArray[0].stocksOwned += [newPosition, newPosition2]
            //println("PRINTING TOTAL STOCK VALUE!!! \(archipelagoArray[0].totalStockValue)")
            
//TEMP
            portfolioViewController.archipelagoArray = archipelagoArray
        }
        else if segue.identifier == "buySegue" {
            //println("buySellSegue Initiated")
            let buySellViewController = (segue.destinationViewController as! BuySellViewController)
            buySellViewController.user = user
            buySellViewController.archipelago = archipelagoArray[0]
            buySellViewController.buyOrSell = "Buy"
        }
        else if segue.identifier == "sellSegue" {
            let buySellViewController = (segue.destinationViewController as! BuySellViewController)
            buySellViewController.user = user
            buySellViewController.archipelago = archipelagoArray[0]
            buySellViewController.buyOrSell = "Sell"
        }
    }

//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        if segue.identifier == "showDetail" {
//            if let indexPath = self.tableView.indexPathForSelectedRow() {
//                let object = objects[indexPath.row] as! NSDate
//            (segue.destinationViewController as! DetailViewController).detailItem = object
//            }
//        }
//    }

    
    
    
    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return pendingArchInvites.count
        } else if section == 1 {
            return pendingProposalsCellText.count
        } else if section == 2 {
            return archipelagoArray.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if (section == 0) {
            if pendingArchInvites.count == 0 {
                return 0.0
            }
            else {
                return UITableViewAutomaticDimension
            }
        } else if (section == 1) {
            if pendingProposalsCellText.count == 0 {
                return 0.0
            }
            else {
                return UITableViewAutomaticDimension
            }
        } else if (section == 2) {
            if archipelagoArray.count == 0 {
                return 0.0
            }
            else {
                return UITableViewAutomaticDimension
            }
        } else {
            return UITableViewAutomaticDimension
        }
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Pending Archipelago Invites"
        } else if section == 1 {
            return "Pending Proposals"
        } else if section == 2 {
            return "Archipelagos"
        } else {
            return nil
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //if let archipelagos = user?.archipelagosJoined {}
        print("LOADING TABLEVIEW")
        print("dataLoaded is: \(dataLoaded)")
        loadPendingProposals()
        
        let dataStruct = [pendingArchipelagosArray, pendingProposalsCellText, archipelagoArray]
       
//        self.tableView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0, self.tableView.numberOfSections())), withRowAnimation: .None)
        
//        cell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 8.0)
//        cell.textLabel?.lineBreakMode = NSLineBreakMode.ByWordWrapping
//        
//       cell.textLabel?.numberOfLines = 0
        if indexPath.section == 0 {
            let pendingProposalCell = tableView.dequeueReusableCellWithIdentifier("pendingProposalCell", forIndexPath: indexPath) as! VotingButtonsTableViewCell
            
            
            pendingProposalCell.approveButton?.tag = indexPath.section*100 + indexPath.row
            pendingProposalCell.rejectButton?.tag = indexPath.section*100 + indexPath.row
            
//            pendingProposalCell.approveButton?.addTarget(self, action: "approveArchInvite:", forControlEvents: .TouchUpInside)
//            pendingProposalCell.rejectButton?.addTarget(self, action: "rejectArchInvite:", forControlEvents: .TouchUpInside)
            
            
            if let object = dataStruct[indexPath.section][indexPath.row] as? Archipelago {
                pendingProposalCell.proposalTextLabel?.text = object.archID

                pendingProposalCell.approveButton?.addTarget(self, action: "approveProposal:", forControlEvents: .TouchUpInside)
                pendingProposalCell.rejectButton?.addTarget(self, action: "rejectProposal:", forControlEvents: .TouchUpInside)
            }
            
            return pendingProposalCell
        }
        if indexPath.section == 1 {
            let pendingProposalCell = tableView.dequeueReusableCellWithIdentifier("pendingProposalCell", forIndexPath: indexPath) as! VotingButtonsTableViewCell
            
            
            pendingProposalCell.approveButton?.tag = indexPath.section*100 + indexPath.row
            pendingProposalCell.rejectButton?.tag = indexPath.section*100 + indexPath.row
            
            
            if let object = dataStruct[indexPath.section][indexPath.row] as? String {
                pendingProposalCell.proposalTextLabel?.text = object
                
                pendingProposalCell.approveButton?.addTarget(self, action: "approveProposal:", forControlEvents: .TouchUpInside)
                pendingProposalCell.rejectButton?.addTarget(self, action: "rejectProposal:", forControlEvents: .TouchUpInside)
            }

            
            return pendingProposalCell
        }
        else {
            
            let archCell = tableView.dequeueReusableCellWithIdentifier("archCell", forIndexPath: indexPath) 
            
            archCell.textLabel?.font = UIFont(name: "HelveticaNeue-Thin", size: 13.0)
            
            let arch = dataStruct[indexPath.section][indexPath.row] as? Archipelago
            let archname = arch?.archName
            archCell.textLabel?.text = archname
            return archCell
        }

        //return cell
        
    }
    
    @IBAction func approveProposal(sender: UIButton?) {
        
        if sender?.tag < 100 {
            print("approveArchInvite button clicked")
            
            //Get the archipelago that was clicked on
            let proposedArch = pendingArchipelagosArray[sender!.tag] as Archipelago
            
            //Update the Arch's features: Invites, members, status
            proposedArch.invites["Accepted"]?.append(self.user!.userID!)
            proposedArch.invites["Pending"] = proposedArch.invites["Pending"]?.filter{ $0 != self.user!.userID!}
            proposedArch.members.append(self.user!.userID!)
            
            //If there's at least one accepted invite and no pending or rejected invites, the arch should become active
            if !(proposedArch.invites["Pending"]?.count > 0) && (proposedArch.invites["Accepted"]?.count > 0) {
                proposedArch.status = "Active"
            }
            
            //Update the user's info: remove the pending invite, add to archipelagosJoined
            user?.pendingInvites?.removeAtIndex(sender!.tag) //= user?.pendingInvites?.filter() { $0 != "Hello" }
            user?.archipelagosJoined.append(proposedArch.archID!)
            
            //Write to Firebase
            //        proposedArch.writeArch()
            //        user?.updateUserInFirebase()
            
            self.viewDidLoad()
            // MAY NEED TO CHANGE TO self.tableView.reloadData()
            //self.tableView.reloadData()
            //configureTableView()
        }
        else {
            print("Section 2")
            //let proposal = pendingProposals[sender!.tag - 100]
            //Need to:
            //Increment yesVotes; decrement pendingVotes
            if let proposedTrade = pendingProposals[sender!.tag - 100] as? ProposedTrade {
                print("Proposal is a ProposedTrade")
                proposedTrade.yesVotes++
                proposedTrade.pendingVotes--
                pendingProposals[sender!.tag - 100] = proposedTrade
                
                //Add behavior for non-unanimous voting system
                if proposedTrade.pendingVotes == 0 {
                    print("pendingVotes now 0; action will be executed")
                    
                    //SEND TO TRADE EXECUTION ALGORITHM
                    let executedTrade = proposedTrade.executeTrade()
                    
                    //Get rid of:
                    self.pendingProposalsCellText.removeAtIndex(sender!.tag - 100)
                    self.pendingProposals.removeAtIndex(sender!.tag - 100)
                    
                    //In archipelagoArray:
                    //If BUY:
                    if executedTrade.buyOrSell == "Buy" {
                        for arch in archipelagoArray {
                            if arch.archID == executedTrade.archipelagoID {
                                arch.availableCash -= Double(executedTrade.shares) * Double(executedTrade.priceExecuted!)
                                
                                let newStockOwned = StockPosition(executedTrade: executedTrade, goGetQuote: true)
                                arch.stocksOwned.append(newStockOwned)
                                
                                let actionIndex = pendingProposalsIndexes[sender!.tag - 100].1
                                pendingProposalsIndexes.removeAtIndex(sender!.tag - 100)
                                arch.pendingActions.removeAtIndex(actionIndex)
                                
                                arch.actionsHistory?.tradeHistoryExecuted.append(executedTrade)
                            
                                //WRITING TO FIREBASE
                                arch.writeArch()
                                
                                //self.viewDidLoad()
                                self.tableView.reloadData()
                            }
                        }
                    } else if executedTrade.buyOrSell == "Sell" {
                        for arch in archipelagoArray {
                            if arch.archID == executedTrade.archipelagoID {
                                arch.availableCash += Double(executedTrade.shares) * Double(executedTrade.priceExecuted!)
                                
                                var sharesLeftToSell = executedTrade.shares
                                //var stockIndexesToRemove = [Int]()
                                var stockIndex = 0
                                
                                for stock in arch.stocksOwned {
                                    if stock.ticker == executedTrade.ticker {
                                        //sharesLeftToSell = max(-1, sharesLeftToSell - stock.shares!)
                                        if (sharesLeftToSell - stock.shares!) >= 0 {
                                            sharesLeftToSell = sharesLeftToSell - stock.shares!
                                            arch.stocksOwned.removeAtIndex(stockIndex)
                                            stockIndex--
                                        } else {
                                            stock.shares = stock.shares! - sharesLeftToSell
                                            sharesLeftToSell = 0
                                        }
                                    }
                                    
                                    stockIndex++
                                }
                                
                                
                                let actionIndex = pendingProposalsIndexes[sender!.tag - 100].1
                                pendingProposalsIndexes.removeAtIndex(sender!.tag - 100)
                                arch.pendingActions.removeAtIndex(actionIndex)
                                
                                arch.actionsHistory?.tradeHistoryExecuted.append(executedTrade)
                                
                                //WRITING TO FIREBASE
                                arch.writeArch()
                                
                                //self.viewDidLoad()
                                self.tableView.reloadData()
                            }
                            
                        }
                    }
                } else if proposedTrade.pendingVotes > 0 {
                    for arch in archipelagoArray {
                        if arch.archID == proposedTrade.archipelagoID {
                            let actionIndex = pendingProposalsIndexes[sender!.tag - 100].1
                            arch.pendingActions[actionIndex] = proposedTrade
                        }
                    }
                }
                
            } else if let proposedDeposit = pendingProposals[sender!.tag - 100] as? ProposedDeposit {
                print("Proposal is a ProposedDeposit")
                
            } else if let proposedArchRulesChange = pendingProposals[sender!.tag - 100] as? ProposedArchRulesChange {
                print("Proposal is a ProposedArchRulesChange")
            }
        }
        
    }
    @IBAction func rejectProposal(sender: UIButton?) {
        
        if sender?.tag < 100 {
            print("rejectArchInvite button clicked")
            
            
            //IF EVERYONE NEEDS TO JOIN OR ARCH GETS DISMANTLED ADD BEHAVIOR HERE
            
            //Get the archipelago that was clicked on
            let proposedArch = pendingArchipelagosArray[sender!.tag] as Archipelago
            
            //Update the Arch's features: Invites, members, status
            proposedArch.invites["Rejected"]?.append(self.user!.userID!)
            proposedArch.invites["Pending"] = proposedArch.invites["Pending"]?.filter{ $0 != self.user!.userID!}
            
            //If there's at least one accepted invite and no pending invites, the arch should become active
            //IF EVERYONE NEEDS TO JOIN OR ARCH GETS DISMANTLED ADD BEHAVIOR HERE
            if !(proposedArch.invites["Pending"]?.count > 0) && (proposedArch.invites["Accepted"]?.count > 0) {
                proposedArch.status = "Active"
            }
            
            //Update the user's info: remove the pending invite, add to archipelagosJoined
            user?.pendingInvites?.removeAtIndex(sender!.tag) //= user?.pendingInvites?.filter() { $0 != "Hello" }
            
            //Write to Firebase
            //        proposedArch.writeArch()
            //        user?.updateUserInFirebase()
            
            self.viewDidLoad()
            //MAY NEED TO CHANGE TO self.tableView.reloadData()
            
            
            //self.tableView.reloadData()
            //configureTableView()
        }
        else {
            print("Section 2 Reject")
            //let proposal = pendingProposals[sender!.tag - 100]
            //Need to:
            //Increment yesVotes; decrement pendingVotes
            if let proposedTrade = pendingProposals[sender!.tag - 100] as? ProposedTrade {
                print("Proposal is a ProposedTrade")
                proposedTrade.noVotes++
                proposedTrade.pendingVotes--
                pendingProposals[sender!.tag - 100] = proposedTrade
                
                //Add behavior for non-unanimous voting system
                //if proposedTrade.pendingVotes == 0 {
                if proposedTrade.pendingVotes >= 0 {
                    print("Action Rejected by user; action will be rejected")
                    
                    //SEND TO TRADE EXECUTION ALGORITHM
                    let rejectedTrade = RejectedTrade(proposedTrade: proposedTrade)
                    
                    
                    //Get rid of:
                    self.pendingProposalsCellText.removeAtIndex(sender!.tag - 100)
                    self.pendingProposals.removeAtIndex(sender!.tag - 100)
                    
                    //In archipelagoArray:
                    if rejectedTrade.buyOrSell == "Buy" || rejectedTrade.buyOrSell == "Sell" {
                        for arch in archipelagoArray {
                            if arch.archID == rejectedTrade.archipelagoID {
                                let actionIndex = pendingProposalsIndexes[sender!.tag - 100].1
                                pendingProposalsIndexes.removeAtIndex(sender!.tag - 100)
                                arch.pendingActions.removeAtIndex(actionIndex)
                                
                                arch.actionsHistory?.tradeHistoryRejected.append(rejectedTrade)
                                
                                //WRITING TO FIREBASE
                                arch.writeArch()
                                
                                print("right after arch.writeArch()")
                                //self.viewDidLoad()
                                self.tableView.reloadData()
                            }
                        }
                    }
                } //else if proposedTrade.pendingVotes > 0 {
                //}
                
            } else if let proposedDeposit = pendingProposals[sender!.tag - 100] as? ProposedDeposit {
                print("Proposal is a ProposedDeposit")
                
            } else if let proposedArchRulesChange = pendingProposals[sender!.tag - 100] as? ProposedArchRulesChange {
                print("Proposal is a ProposedArchRulesChange")
            }
        }
    }

     override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 || indexPath.section == 1 {
            performSegueWithIdentifier("PendingProposalSegue", sender: self)
        }
        else if indexPath.section == 2 {
            performSegueWithIdentifier("PortfolioSegue", sender: self)
        }
        
    }

//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            objects.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        } else if editingStyle == .Insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
//        }
//    }
    
    
    func loadPendingProposals(){
        print("start of loadPendingProposals")
        pendingProposals = []
        pendingProposalsCellText = []
        pendingProposalsIndexes = [] //(ArchID, pendingActionIndex)
        for arch in archipelagoArray {
            //if arch.archCreatorID != nil {
            var actionIndex = 0
                for action in arch.pendingActions {
                    if let typedAction = action as? ProposedTrade {
                        pendingProposals.append(typedAction)
                        pendingProposalsCellText.append(typedAction.proposedTradeCellText())
                        pendingProposalsIndexes.append((typedAction.archipelagoID!, actionIndex))
                        //println("it's a proposedTrade")
                        
                    } else if let typedAction = action as? ProposedDeposit {
                        pendingProposals.append(typedAction)
                        pendingProposalsCellText.append(typedAction.proposedDepositCellText())
                        pendingProposalsIndexes.append((typedAction.archipelagoID!, actionIndex))
                        
                    } else if let typedAction = action as? ProposedArchRulesChange {
                        pendingProposals.append(typedAction)
                        pendingProposalsCellText.append(typedAction.proposedArchRuleChangesCellText())
                        pendingProposalsIndexes.append((typedAction.archipelagoID!, actionIndex))
                    }
                    
                    actionIndex++
                }
            
            //}
        }
        print("End of loadPendingProposals")
    }
    
}
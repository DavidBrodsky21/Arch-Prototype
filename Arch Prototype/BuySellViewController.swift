//
//  BuySellViewController.swift
//  Arch Prototype
//
//  Created by David Brodsky on 8/23/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import UIKit

class BuySellViewController: UIViewController, UITextFieldDelegate {
    
    var archipelago: Archipelago?
    var user: User?
    
    var newProposal: Proposal?
    var newProposedTrade: ProposedTrade?
    
    var buyOrSell: String?
    var orderType: String?
    var ticker: String?
    var shares: Int?
    var limitPrice: Double?
    var proposalLength: Int?

    @IBOutlet weak var archipelagoChoiceLabel: UITextField?
    @IBOutlet weak var orderTypeLabel: UITextField?
    @IBOutlet weak var buyOrSellLabel: UITextField?
    @IBOutlet weak var tickerLabel: UITextField?
    @IBOutlet weak var numSharesLabel: UITextField?
    @IBOutlet weak var proposalLengthLabel: UITextField?
    @IBOutlet weak var limitPriceLabel: UITextField?
    @IBOutlet weak var costIfExecutedLabel: UILabel?
    
    @IBAction func proposeTradeButton(sender: UIButton) {
        
        //NEED TO ADJUST THIS TO TAKE IN "archipelagoChoice"
        if let archipelagoChosen = archipelago {
            newProposal = Proposal(archipelago: archipelagoChosen)
            newProposedTrade = ProposedTrade(archipelago: archipelagoChosen, proposal: newProposal!)
            
            readUserInput(newProposedTrade!)
            
            archipelago?.pendingActions.append(newProposedTrade!)
            archipelago?.actionsHistory?.tradeHistoryProposed.append(newProposedTrade!)
            
            print("PRINTING ARCH DESCRIPTION")
            print("")
//            println(archipelago!.actionsHistory?.tradeHistory.description)
            print(archipelago!.actionsHistory?.tradeHistoryProposed)
            
            archipelago!.writeArch()
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func readUserInput(proposedTrade: ProposedTrade) {
        if let userIDVal = user?.fullName {
            proposedTrade.proposer = userIDVal
        }
        if let proposalLength = proposalLengthLabel?.text!.componentsSeparatedByString(" ") {
            proposedTrade.proposalLength = NSNumberFormatter().numberFromString(proposalLength[0])!.integerValue
        }
        if let buyOrSell = buyOrSellLabel?.text {
            proposedTrade.buyOrSell = buyOrSell
        }
        if let ticker = tickerLabel?.text{
            proposedTrade.ticker = ticker
        }
        if let shares = numSharesLabel?.text {
           proposedTrade.shares = NSNumberFormatter().numberFromString(shares)!.integerValue
        }
        if let limitPrice   = limitPriceLabel?.text {
            proposedTrade.limitPrice = NSNumberFormatter().numberFromString(limitPrice)!.doubleValue
        }
    }
    
    

    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var _: String

        archipelagoChoiceLabel!.text = archipelago?.archName
        //archipelagoChoiceLabel?.adjustsFontSizeToFitWidth
        buyOrSellLabel!.text = buyOrSell
        tickerLabel!.placeholder = "Enter a ticker" //attributedPlaceholder
        tickerLabel?.delegate = self

        numSharesLabel!.text = "1"
        numSharesLabel?.delegate = self
        
        if let proposalLength = archipelago?.archRules.maxDaysProposalPending {
            proposalLengthLabel!.text = "\(proposalLength) Days"
        }
        limitPriceLabel!.text = "--"
        costIfExecutedLabel!.text = "--"
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

    
    
    // UITextField Delegates
//    func textFieldDidBeginEditing(textField: UITextField) {
//        println("TextField did begin editing method called")
//    }
    func textFieldDidEndEditing(textField: UITextField) {
        print("TextField did end editing method called")
        if let ticker = tickerLabel?.text {
            if let lastTradePrice = lookupTicker(ticker),
                let numSharesString = numSharesLabel?.text {
                limitPriceLabel?.text = "\(lastTradePrice)"
            
                let numShares = NSNumberFormatter().numberFromString(numSharesString)!.doubleValue
                
                let costIfExecuted = numShares * lastTradePrice
                costIfExecutedLabel?.text = "\(costIfExecuted)"
            }
        }
    }
//    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
//        println("TextField should begin editing method called")
//        return true;
//    }
//    func textFieldShouldClear(textField: UITextField) -> Bool {
//        println("TextField should clear method called")
//        return true;
//    }
//    func textFieldShouldEndEditing(textField: UITextField) -> Bool {
//        println("TextField should snd editing method called")
//        return true;
//    }
//    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
//        println("While entering the characters this method gets called")
//        return true;
//    }
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        println("TextField should return method called")
//        textField.resignFirstResponder();
//        return true;
//    }

    
    
//HELPER FUNCTIONS
    func lookupTicker(ticker: String) -> Double? {
        if let stockQuoteDictionary = getQuoteDictionary(ticker) {
            let quote = StockQuote(stockQuoteDict: stockQuoteDictionary)
            print("\(quote.ticker)'s name is \(quote.name) and it's lastTradePrice was: \(quote.lastTradePrice)")
            return quote.lastTradePrice
        }
        else {
            print("Couldn't find stock quote")
            return nil
        }
    }
}

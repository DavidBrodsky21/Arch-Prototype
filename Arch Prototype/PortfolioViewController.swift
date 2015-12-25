//
//  PortfolioViewController.swift
//  Arch Prototype
//
//  Created by David Brodsky on 8/17/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import UIKit

class PortfolioViewController: UITableViewController {
    var archipelagoArray = [Archipelago]()
    

    @IBOutlet weak var totalPortfolioValueLabel: UILabel!
    @IBOutlet weak var unusedFundsLabel: UILabel!
    @IBOutlet weak var dailyChangeDollars: UILabel!
    @IBOutlet weak var dailyChangePct: UILabel!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let stocksOwned = archipelagoArray[0].stocksOwned
        var tickers = [String]()
        for indexNum in 0..<stocksOwned.count{
            tickers.insert(stocksOwned[indexNum].ticker!, atIndex: indexNum)
        }
        
        var stockQuotesDictionaries = [[String: AnyObject]?]()
        var stockQuotesArray = [StockQuote]()
        
        for indexNum in 0..<tickers.count {
            stockQuotesDictionaries.insert(getQuotesDictionary(tickers, index: indexNum), atIndex: indexNum)
            
            if let stockQuoteDictionary = stockQuotesDictionaries[indexNum]{
                stockQuotesArray.insert(StockQuote(stockQuoteDict: stockQuoteDictionary), atIndex: indexNum)
            }
            print(stockQuotesArray.description)
            
            
        }
        // LabelTest?.text = archipelago1.invites.indexForKey("Pending")
        //LabelTest?.text = userUID
        //LabelTest1?.text = stockQuotesArray[1].ticker
        
        
        totalPortfolioValueLabel.text = archipelagoArray[0].totalStockValue?.description
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return archipelagoArray.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //if let archipelagos = user?.archipelagosJoined {}
        
        //var archNameArray = archipelagoArray
        //var archPerformance =
        var dataStruct = archipelagoArray[0].stocksOwned
        //println(user?.archipelagosJoined)
        //        if let Archipelagos = user?.archipelagosJoined {
        //            var dataStruct = [pendingProposals, Archipelagos]
        //        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell2", forIndexPath: indexPath) 
        //        let object = pendingProposals[indexPath.row]
        if let object = dataStruct[indexPath.row].ticker {
            cell.textLabel!.text = object
        }
        
        return cell
    }

    /*
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as! UITableViewCell

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}

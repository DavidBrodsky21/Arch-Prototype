
//: Playground - noun: a place where people can play

import Cocoa
import Foundation
//import UIKit

class Archipelago: Serializable {
    var archName: String?
    var archID: String?
    var status: String //enum?
    var invites: [String: [String]] // "Pending"/"Accepted": [userID as string]
    //(Friend, status); status should be enum? who has been invited or invited and outstanding?
    var availableCash: Double
    var stocksOwned:[StockPosition]
    var originalMoneyInvested: Double //maybe should be calculated, maybe need other things like this
    var members: [String?] //ID #s; look up in seperate table for info
    var archCreatorID: String? //ID #; look up in seperate table for info
    
    //Date of Creation Vars
    var dateOfCreation: NSTimeInterval //Date when invites are sent
    //    var dateOfCreationString: String? {
    //        get{
    //            return dateAsString(dateOfCreation, defaultDateFormat)
    //        }
    //        set {
    //            dateOfCreation = stringAsDate(newValue!, defaultDateFormat)!
    //        }
    //    }
    
    //Date of invite Expiration
    var dateOfInviteExpiration: NSTimeInterval? //{
    //        get{
    //            if status == "Pending" {
    //                var maxSecondsInvitePending: NSTimeInterval = Double(self.archRules.maxDaysInvitePending) * 24.0 * 60.0 * 60.0
    //                return dateOfCreation + maxSecondsInvitePending
    //            } else {
    //                return nil
    //            }
    //        }
    //    }
    
    //    var dateOfInviteExpirationString: String? {
    //        get{
    //            return dateAsString(dateOfInviteExpiration!, defaultDateFormat)
    //        }
    //    }
    
    //Date of Activation
    var dateOfActivation: NSTimeInterval? //Date when everyone accepts invite
    
    //    var dateOfActivationString: String? {
    //        get{
    //            if dateOfActivation != nil {
    //                return dateAsString(dateOfActivation!, defaultDateFormat)
    //            } else {
    //                return nil
    //            }
    //        }
    //        set {
    //            if newValue != nil {
    //                dateOfActivation = stringAsDate(newValue!, defaultDateFormat)!
    //            }
    //        }
    //    }
    
    var pendingActions: [Proposal]? //[Action]?
    var actionsHistory: ActionsHistory?
    var archRules: ArchRule
    var archRulesDict: NSDictionary? {
        get {
            return archRules.toDictionary()
        }
    }
    
    //    var chat: [String] //PROBABLY WILL NEED TO CHANGE
    //    var depositSchedule: Int //Enum fo sho //moved to archRules
    var totalStockValue: Double? {
        get{
            return getTotalStockValue()
        }
    }
    
    var totalArchValue: Double? {
        get{
            if let totalStock = totalStockValue {
                return totalStock + availableCash
            }
            else {
                return nil
            }
        }
    }
    
    var dailyPriceChangeDollars: Double? {
        get {
            return 0.00000 //getDailyPriceChangeDollars
        }
    }
    
    
    var dailyPriceChangePct: Double?
    /*Other time-frame price changes*/
    
    init(friendsInvited: [String]){
        //self.archName = archipelagoName
        //archID = 0 //UPDATE THIS
        status = "Pending"
        //self.invites = [(friendsInvited[0], "Accepted"), (friendsInvited[1], "Pending")]
        self.invites = ["Pending": friendsInvited, "Accepted": []]
        availableCash = 0
        stocksOwned = []
        originalMoneyInvested = 0
        members = []
        //self.archCreatorID = archCreatorID //THINK HOW THIS WILL GET POPULATED
        
        dateOfCreation = NSDate().timeIntervalSince1970
        
        actionsHistory = ActionsHistory(dateOfCreation: self.dateOfCreation, archCreatorID: self.archCreatorID) //Need to initialize memberhistory
        archRules = ArchRule() //ArchRules //Initiate to some default?
        
        var maxSecondsInvitePending: NSTimeInterval = Double(self.archRules.maxDaysInvitePending) * 24.0 * 60.0 * 60.0
        dateOfInviteExpiration = dateOfCreation + maxSecondsInvitePending
        
        
        
        
        //        chat: [String] //PROBABLY WILL NEED TO CHANGE
        //        depositSchedule = 1
    }
    
    override init(){
        //self.archName = archipelagoName
        //archID = 0 //UPDATE THIS
        status = "Pending"
        //self.invites = [(friendsInvited[0], "Accepted"), (friendsInvited[1], "Pending")]
        self.invites = ["Pending": [], "Accepted": []]
        availableCash = 0
        stocksOwned = []
        originalMoneyInvested = 0
        members = []
        //self.archCreatorID = archCreatorID //THINK HOW THIS WILL GET POPULATED
        
        dateOfCreation = NSDate().timeIntervalSince1970
        
        //actionsHistory = ["Archipelago Initiated, Invites Sent!"] //Need to create Activity class
        actionsHistory = ActionsHistory(dateOfCreation: self.dateOfCreation, archCreatorID: self.archCreatorID) //Need to create Activity class
        archRules = ArchRule() //ArchRules //Initiate to some default?
        
        var maxSecondsInvitePending: NSTimeInterval = Double(self.archRules.maxDaysInvitePending) * 24.0 * 60.0 * 60.0
        dateOfInviteExpiration = dateOfCreation + maxSecondsInvitePending
        
        //        chat: [String] //PROBABLY WILL NEED TO CHANGE
        //        depositSchedule = 1
    }
    
    
    //CALCULATE ARCH VALUE FUNCTIONS
    func getTotalStockValue()-> Double {
        var totalStockValue = 0.0000
        for indexNum in 0..<self.stocksOwned.count {
            //stocksOwned[indexNum].getCurrentPrice()
            
            if let shares = stocksOwned[indexNum].shares,
                let currentPrice = stocksOwned[indexNum].stockQuote?.lastTradePrice {
                    totalStockValue += currentPrice * Double(shares)
            }
        }
        return totalStockValue
    }
    
    //Just for stocks, not cash
    func getDailyPriceChangeDollars() -> Double {
        var dailyPriceChangeDollars = 0.0000
        for indexNum in 0..<self.stocksOwned.count {
            if let shares = stocksOwned[indexNum].shares,
                let dailyChangeDollar = stocksOwned[indexNum].stockQuote?.dailyChangeDollar { //WHAT DOES THIS LOOK LIKE AFTER MARKET CLOSE
                    dailyPriceChangeDollars += dailyChangeDollar * Double(shares)
            }
        }
        return dailyPriceChangeDollars
    }
    
    //Just for stocks, not cash
    //    func getDailyPriceChangePct() -> Double {
    //        var totalStockValueOpen = 0.0000
    //        var dailyPriceChangePct = 0.0000
    //        //Calculate total stock value at open
    //        for indexNum in 0..<self.stocksOwned.count {
    //            if let shares = stocksOwned[indexNum].shares,
    //                let openPrice = stocksOwned[indexNum].stockQuote?.openPrice { //WHAT DOES THIS LOOK LIKE AFTER MARKET CLOSE
    //                    totalStockValueOpen += openPrice * Double(shares)
    //            }
    //        }
    ////        for indexNum in 0..<self.stocksOwned.count {
    ////            if let shares = stocksOwned[indexNum].shares,
    ////                let dailyChangeDollar = stocksOwned[indexNum].stockQuote?.dailyChangeDollar { //WHAT DOES THIS LOOK LIKE AFTER MARKET CLOSE
    ////                    dailyPriceChangeDollars += dailyChangeDollar * Double(shares)
    ////            }
    //        }
    //
    //
    //
    //        return dailyPriceChangePct
    //    }
    
    //FIREBASE FUNCTIONS
    
    //write funcs
    func writeNewArch() {
        let archRef = FirebaseRef.childByAppendingPath("Arch/")
        let archToWrite = self.toDictionary()
        let individArchRef = archRef.childByAutoId()
        individArchRef.setValue(archToWrite)
        
        self.archID = individArchRef.key
    }
    
    func writeArch() {
        let individArchRef = FirebaseRef.childByAppendingPath("Arch/\(self.archID!)")
        let archToWrite = self.toDictionary()
        individArchRef.setValue(archToWrite)
    }
    
    //read funcs
    func readArchFromFirebase (tableViewToReload tableViewToReload: AnyObject?){
        /*Starting firebasefunc*/
        var RefPath = FirebaseRef.childByAppendingPath("Arch/\(self.archID!)")
        println(RefPath)
        //IMPORTANT: note single event observation, think through implications.
        RefPath.observeEventType(.Value, withBlock: {
            snapshot in
            var archDict: NSDictionary = snapshot.value as! NSDictionary
            
            if let archName = archDict["archName"] as? String {
                self.archName = archName
            }
            if let archID = archDict["archID"] as? String {
                self.archID = archID
            }
            if let status = archDict["status"] as? String {
                self.status = status
            }
            if let invites = archDict["invites"] as? [String: [String]] {
                self.invites = invites
            }
            if let availableCash = archDict["availableCash"] as? Double {
                self.availableCash = availableCash
            }
            if let stocksOwned = archDict["stocksOwned"] as? [StockPosition] {
                self.stocksOwned = stocksOwned
            }
            if let originalMoneyInvested = archDict["originalMoneyInvested"] as? Double {
                self.originalMoneyInvested = originalMoneyInvested
            }
            if let members = archDict["members"] as? [String?] {
                self.members = members
            }
            if let archCreatorID = archDict["archCreatorID"] as? String {
                self.archCreatorID = archCreatorID
            }
            if let dateOfCreation = archDict["dateOfCreation"] as? NSTimeInterval {
                self.dateOfCreation = dateOfCreation
            }
            //Should this be blanks since it is "gotten"
            if let dateOfInviteExpiration = archDict["dateOfInviteExpiration"] as? NSTimeInterval {
                self.dateOfInviteExpiration = dateOfInviteExpiration
            }
            if let dateOfActivation = archDict["dateOfActivation"] as? NSTimeInterval {
                self.dateOfActivation = dateOfActivation
            }
            if let pendingActions = archDict["pendingActions"] as? [Proposal] {
                self.pendingActions = pendingActions
            }
            if let actionsHistory = archDict["actionsHistory"] as? ActionsHistory {
                self.actionsHistory = actionsHistory
            }
            if let archRules = archDict["archRules"] as? ArchRule {
                self.archRules = archRules
            }
            if let dateOfActivation = archDict["dateOfActivation"] as? NSTimeInterval {
                self.dateOfActivation = dateOfActivation
            }
            println("In readArchFromFirebase")
            println(archDict.description)
            //Start Dictionary to user
            //memberUser.userPropertiesFromDictionary(userDict)
            //End dictionary to user
            //self.tableView.reloadData()
            tableViewToReload?.reloadData()
            
        })
    }
}

let friend1 = Friend()
let archName = "Arch1"
let archipelago1 = Archipelago(friendsInvited: ["simplelogin:21"])


////Archipelago rules
class ArchRule: Serializable {
    var votingSystem: String // make into enum
    var minInvestment: Double?
    var maxInvestment: Double?
    var forceEqualInvestment: Bool //does each arch member have to have the same contribution?
    var maxDaysProposalPending: Int //max days until an action proposal expires
    var maxDaysInvitePending: Int //max days until Arch invitation expires
    var commentsAtInception: String?
    var depositSchedule: Int //Enum fo sho //
    //var HOW TO HANDLE EARLY LIQUIDATIONS
    //var archipelagoExpiration: //When does an arch expire automatically (handle informally for now)
    //var openToFutureInvestors: Bool
    //var memberInvestmentAmountPublic: Bool
    //var abilityToKickSomeoneOut: Bool
    
    override init(){
        votingSystem = "Unanimous" //Enum
        minInvestment = 50
        forceEqualInvestment = true
        maxDaysProposalPending = 3
        maxDaysInvitePending = 5
        depositSchedule = 1 //Enum
    }
}



/*Actions:
1)  Trade - Buy/Sell
2)  Deposit
3)  Change terms

A) Pending
B) Executed
C) Rejected
*/

class Proposal {
    let archipelago: String?
    let proposer: String
    
    // Will use Archipelago property to calculate time left until expiration
    let dateProposed: NSTimeInterval //NSDate
    let proposalLength: Int // take this from Arch characteristics; need to think about type
    var dateExpiring: NSTimeInterval? {
        get{
            let ProposalLengthSeconds: NSTimeInterval = Double(proposalLength) * 24.0 * 60.0 * 60.0
            return dateProposed + ProposalLengthSeconds
        }
    }
    
    //Section off this "voting" behavior in the future
    let numOfArchMembers: Int
    var yesVotes: Int
    var noVotes: Int
    var pendingVotes: Int
    
    init(archipelago: Archipelago){
        self.archipelago = archipelago.archName
        proposer = "David"
        
        dateProposed = NSDate().timeIntervalSince1970
        proposalLength = archipelago.archRules.maxDaysProposalPending
        numOfArchMembers = archipelago.members.count
        yesVotes = 0
        noVotes = 0
        pendingVotes = numOfArchMembers //REVISE
    }
    
}


//TRADES
class ProposedTrade: Proposal {
    
    let type: String //buy or sell; make enum; potentially sub-type w/ limit vs. market or whatever
    //let orderType: orderType (enum)
    let ticker: String
    let shares: Int
    let limitPrice: Double?
    
    override init(archipelago: Archipelago){
        type = "Buy"
        ticker = "MSFT"
        shares = 1
        limitPrice = 0.0
        
        super.init(archipelago: archipelago)
    }
    
    func proposedTradeCellText() -> String {
        var pluralizeShares = "s"
        if shares == 1 {
            pluralizeShares = ""
        }
        
        return "\(archipelago) | \(proposer) proposed \(type.lowercaseString)ing \(shares) share\(pluralizeShares) of \(ticker) at $\(limitPrice) per share."
    }
}


class ExecutedTrade: ProposedTrade {
    let dateAccepted: NSTimeInterval
    let dateExecuted: NSTimeInterval?
    
    let priceExecuted: Double?
    
    override init(archipelago: Archipelago){
        dateAccepted = NSDate().timeIntervalSince1970
        dateExecuted = nil
        priceExecuted = nil
        
        super.init(archipelago: archipelago)
    }
}

class RejectedTrade: ProposedTrade {
    let dateRejected: NSTimeInterval
    
    override init(archipelago: Archipelago){
        dateRejected = NSDate().timeIntervalSince1970
        super.init(archipelago: archipelago)
    }
}








//MAKE SURE THAT ALL THE VARS HERE ARE IN THE NEW YQL SOURCE
struct StockQuote {
    var ticker: String? //going to check 2 vars for "ticker"; may want to redo this and make it an if let later
    var name: String?
    var dailyChangeDollar: Double?
    var dailyChangePct: Double? //going to check 2 vars for this var; may want to redo this and make it an if let later
    var currency: String?
    var daysLow: Double?
    var daysHigh: Double?
    var yearLow: Double?
    var yearHigh: Double?
    var marketCap: String? //Double? //note that "MarketCapitalization" from YQL comes as a string, e.g. "714.74B"
    var EBITDA: String? //Double?  //note that "EBITDA" from YQL comes as a string, e.g. "72.94B"
    var lastTradePrice: Double?
    var openPrice: Double?
    var previousClose: Double?
    var PERatio: Double?
    var volume: Int?
    var stockExchange: String?
    var dividendYield: Double?
    
    init(stockQuoteDict: [String: AnyObject]){
        if let tickerVal = stockQuoteDict["symbol"] as? String {
            ticker = tickerVal
        }
        if ticker == nil {
            if let tickerVal = stockQuoteDict["Symbol"] as? String {
                ticker = tickerVal
            }
        }
        if let nameVal = stockQuoteDict["Name"] as? String {
            name = nameVal
        }
        if let dailyChangeDollarVal = stockQuoteDict["Change"] as? String {
            dailyChangeDollar = NSNumberFormatter().numberFromString(dailyChangeDollarVal)!.doubleValue
        }
        if let dailyChangePctVal = stockQuoteDict["PercentChange"] as? String {
            let dailyChangePctVal = dailyChangePctVal.substringToIndex(dailyChangePctVal.endIndex.predecessor())
            dailyChangePct = NSNumberFormatter().numberFromString(dailyChangePctVal)!.doubleValue / 100.000
        }
        if dailyChangePct == nil {
            if let dailyChangePctVal = stockQuoteDict["ChangeinPercent"] as? String {
                let dailyChangePctVal = dailyChangePctVal.substringToIndex(dailyChangePctVal.endIndex.predecessor())
                dailyChangePct = NSNumberFormatter().numberFromString(dailyChangePctVal)!.doubleValue / 100.000
            }
        }
        if let currencyVal = stockQuoteDict["Currency"] as? String {
            currency = currencyVal
        }
        if let daysLowVal = stockQuoteDict["DaysLow"] as? String {
            daysLow = NSNumberFormatter().numberFromString(daysLowVal)!.doubleValue
        }
        if let daysHighVal = stockQuoteDict["DaysHigh"] as? String {
            daysHigh = NSNumberFormatter().numberFromString(daysHighVal)!.doubleValue
        }
        if let yearLowVal = stockQuoteDict["YearLow"] as? String {
            yearLow = NSNumberFormatter().numberFromString(yearLowVal)!.doubleValue
        }
        if let yearHighVal = stockQuoteDict["YearHigh"] as? String {
            yearHigh = NSNumberFormatter().numberFromString(yearHighVal)!.doubleValue
        }
        //Convert to Double
        if let marketCapVal = stockQuoteDict["MarketCapitalization"] as? String {
            marketCap = marketCapVal
        }
        //Convert to Double
        if let EBITDAVal = stockQuoteDict["EBITDA"] as? String {
            EBITDA = EBITDAVal
        }
        if let lastTradePriceVal = stockQuoteDict["LastTradePriceOnly"] as? String {
            lastTradePrice = NSNumberFormatter().numberFromString(lastTradePriceVal)!.doubleValue
        }
        if let openPriceVal = stockQuoteDict["Open"] as? String {
            openPrice = NSNumberFormatter().numberFromString(openPriceVal)!.doubleValue
        }
        if let previousCloseVal = stockQuoteDict["PreviousClose"] as? String {
            previousClose = NSNumberFormatter().numberFromString(previousCloseVal)!.doubleValue
        }
        if let PERatioVal = stockQuoteDict["PERatio"] as? String {
            PERatio = NSNumberFormatter().numberFromString(PERatioVal)!.doubleValue
        }
        if let volumeVal = stockQuoteDict["Volume"] as? String {
            volume = NSNumberFormatter().numberFromString(volumeVal)!.integerValue
        }
        if let stockExchangeVal = stockQuoteDict["StockExchange"] as? String {
            stockExchange = stockExchangeVal
        }
        if let dividendYieldVal = stockQuoteDict["DividendYield"] as? String {
            dividendYield = NSNumberFormatter().numberFromString(dividendYieldVal)!.doubleValue
        }
    }
}



class StockPosition {
    let ticker: String? //going to check 2 vars for "ticker"; may want to redo this and make it an if let later
    var shares: Int?
    let originalPurchasePrice: Double?
    
    var stockQuote: StockQuote?
    
    init(executedTrade: ExecutedTrade, goGetQuote: Bool){
        ticker = executedTrade.ticker
        shares = executedTrade.shares
        originalPurchasePrice = executedTrade.priceExecuted
//        if goGetQuote == true {
//            getQuote()
//        }
    }
    
    init(ticker: String, shares: Int, originalPurchasePrice: Double, goGetQuote: Bool){
        self.ticker = ticker
        self.shares = shares
        self.originalPurchasePrice = originalPurchasePrice
        
//        if goGetQuote == true {
//            getQuote()
//        }
    }
    
//    func getQuote() {
//        if let tempDict = getQuoteDictionary(self.ticker!) {
//            println("In getQuote")
//            stockQuote = StockQuote(stockQuoteDict: tempDict)
//            println("stockQuote.lastPrice: \(stockQuote?.lastTradePrice)")
//        }
//        else {
//            println("Couldn't get current Price")
//        }
//    }
}



struct PortfolioHistoryEntry {
    var date: NSTimeInterval?
    var open: Bool?
    var stocksOwned: [StockPosition]?
    var availableCash: Double?
    
    init(){}
    
    //init from new trade
    init(executedTrade: ExecutedTrade, stocksOwnedPrior: [StockPosition], availableCashPrior: Double){
        self.date = executedTrade.dateExecuted
        self.open = false
        
        //self.stocksOwned
    }
    
    //init from it being a new day, we're getting a snapshot of portfolio at opening
    init(stocksOwnedPrior: [StockPosition], availableCashPrior: Double) {
        //self.date = executedTrade.dateExecuted
        self.open = true
        self.stocksOwned = stocksOwnedPrior
        self.availableCash = availableCashPrior
    }
    
    
    
}

struct PortfolioHistory {
    var portfolioHistoryEntries: [PortfolioHistoryEntry]
    
    init(){
        portfolioHistoryEntries = []
    }
}



//PLAYGROUND START
var arch1 = Archipelago(friendsInvited: [])
var execTrade = ExecutedTrade(archipelago: arch1)
var stockPos1 = StockPosition(executedTrade: execTrade, goGetQuote: false)

var portHist = PortfolioHistoryEntry(executedTrade: execTrade, stocksOwnedPrior: [stockPos1], availableCashPrior: 100.00)


//portHist.stocksOwned.














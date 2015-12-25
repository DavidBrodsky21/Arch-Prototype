//
//  Helper Functions.swift
//  Arch Prototype
//
//  Created by David Brodsky on 8/6/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

//Date & Time Functions
let defaultDateFormat = "yyyy-MM-dd-HH-mm-SSS"

func dateAsString(date: NSDate, format: String?) -> String? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = format
    let dateAsString = dateFormatter.stringFromDate(date)
    return dateAsString
}

func stringAsDate(dateAsString: String, format: String?) -> NSDate? {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = format
    let stringAsDate = dateFormatter.dateFromString(dateAsString)
    return stringAsDate
}

func numDaysToSeconds(days: Int) -> Double{
    return Double(days) * 24.0 * 60.0 * 60.0
}

//Other
func objectToDictionary(object: NSObject?) -> [String: AnyObject]? {
    if let objectUnwrapped: NSObject = object {
        let properties = objectUnwrapped.propertyNames()
        var objectDict = [String: AnyObject]()
        
        for property in properties {
            if let value: AnyObject = objectUnwrapped.valueForKey(property) {
                objectDict[property] = value
            }
        }
        return objectDict
    } else {
        return nil
    }
}
//
//  Obtained from here: http://derpturkey.com/get-property-names-of-object-in-swift/
//
//  NSObject Extension.swift
//  Arch Prototype
//
//  Created by David Brodsky on 8/26/15.
//  Copyright (c) 2015 Arch Developers. All rights reserved.
//

import Foundation

extension NSObject {
    
    //
    // Retrieves an array of property names found on the current object
    // using Objective-C runtime functions for introspection:
    // https://developer.apple.com/library/mac/documentation/Cocoa/Conceptual/ObjCRuntimeGuide/Articles/ocrtPropertyIntrospection.html
    //
    func propertyNames() -> Array<String> {
        var results: Array<String> = [];
        
        // retrieve the properties via the class_copyPropertyList function
        var count: UInt32 = 0;
        let myClass: AnyClass = self.classForCoder;
        let properties = class_copyPropertyList(myClass, &count);
        
        // iterate each objc_property_t struct
        for var i: UInt32 = 0; i < count; i++ {
            let property = properties[Int(i)];
            
            // retrieve the property name by calling property_getName function
            let cname = property_getName(property);
            
            // covert the c string into a Swift string
            let name = String.fromCString(cname);
            results.append(name!);
        }
        
        // release objc_property_t structs
        free(properties);
        
        return results;
    }
    
}
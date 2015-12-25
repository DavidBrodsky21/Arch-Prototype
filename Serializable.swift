/*FILE OBTAINED FROM: https://github.com/Mailcloud/swift-serializer */
/*Deleted middle part*/

/*

    Converts A class to a dictionary, used for serializing dictionaries to JSON

    Supported objects:
    - Serializable derived classes (sub classes)
    - Arrays of Serializable
    - NSData
    - String, Numeric, and all other NSJSONSerialization supported objects

*/

import Foundation

public class Serializable: NSObject {
    
    /**
        Converts the class to a dictionary.
    
        :returns: The class as an NSDictionary.
    */
    public func toDictionary() -> NSDictionary {
        let propertiesDictionary = NSMutableDictionary()
        //let mirror = reflect(self)
        let mirror = Mirror(reflecting: self)

        for c in mirror.children {
            let propName = c.label
            let childMirror = c.value
        
        //for i in 1..<mirror.count {
         //   let (propName, childMirror) = mirror[i]
            
            if let propValue: AnyObject = self.unwrap(childMirror) as? AnyObject {
                if let serializablePropValue = propValue as? Serializable {
                    propertiesDictionary.setValue(serializablePropValue.toDictionary(), forKey: propName!)
                } else if let arrayPropValue = propValue as? [Serializable] {
                    var subArray = [NSDictionary]()
                    for item in arrayPropValue {
                        subArray.append(item.toDictionary())
                    }
                    
                    propertiesDictionary.setValue(subArray, forKey: propName!)
                } else if propValue is Int || propValue is Double || propValue is Float {
                    propertiesDictionary.setValue(propValue, forKey: propName!)
                } else if let dataPropValue = propValue as? NSData {
                    propertiesDictionary.setValue(dataPropValue.base64EncodedStringWithOptions(.Encoding64CharacterLineLength), forKey: propName!)
                } else if let boolPropValue = propValue as? Bool {
                    propertiesDictionary.setValue(boolPropValue, forKey: propName!)
                } else {
                    propertiesDictionary.setValue(propValue, forKey: propName!)
                }
            }
        }
        
        return propertiesDictionary
    }
}

extension Serializable {
    /**
     Unwraps 'any' object. See http://stackoverflow.com/questions/27989094/how-to-unwrap-an-optional-value-from-any-type
     
     :returns: The unwrapped object.
     */
        private func unwrap(any: Any) -> Any? {
            
            let mi = Mirror(reflecting: any)
            
            if mi.descendant("Some") == nil { // not sure in this row but seems it works
                return any
            }
            
            if mi.children.count == 0 {
                return nil
            }
            
            let (_, some) = mi.children.first!
            
            return some
        }
}


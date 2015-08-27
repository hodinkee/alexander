//
//  JSON.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/24/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Foundation

public struct JSON {
    
    // MARK: - Initializers
    
    public init(object: AnyObject) {
        self.object = object
    }

    
    // MARK: - Properties
    
    public var object: AnyObject

    public subscript(index: Int) -> JSON? {
        let array = object as? [AnyObject]
        return (array?[index]).map({ JSON(object: $0) })
    }

    public subscript(key: String) -> JSON? {
        let dictionary = object as? [String: AnyObject]
        return (dictionary?[key]).map({ JSON(object: $0) })
    }

    public var string: String? {
        return object as? String
    }

    public var dictionary: [String: JSON]? {
        return (object as? [String: AnyObject])?.mapValues({ JSON(object: $0) })
    }

    public var array: [JSON]? {
        return (object as? [AnyObject])?.map({ JSON(object: $0) })
    }

    public var int: Int? {
        return object as? Int
    }

    public var double: Double? {
        return object as? Double
    }

    public var bool: Bool? {
        return object as? Bool
    }

    public var url: NSURL? {
        return string.flatMap({ NSURL(string: $0) })
    }

    public var timeInterval: NSTimeInterval? {
        return object as? NSTimeInterval
    }

    public var date: NSDate? {
        return timeInterval.map({ NSDate(timeIntervalSince1970: $0) })
    }
    
    
    // MARK: - Functions
    
    public func decodeArray<T>(transform: JSON -> T?) -> [T]? {
        let block: ([T], AnyObject) -> [T] = { array, element in
            switch transform(JSON(object: element)) {
            case .Some(let object):
                return array + CollectionOfOne(object)
            case .None:
                return array
            }
        }
        return (object as? [AnyObject]).map({ reduce($0, [T](), block) })
    }
}

extension JSON {
    public init?(data: NSData, options: NSJSONReadingOptions = .allZeros) {
        if let object: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: options, error: nil) {
            self.object = object
        }
        else {
            return nil
        }
    }

    public func data(options: NSJSONWritingOptions = .allZeros) -> NSData? {
        if NSJSONSerialization.isValidJSONObject(object) {
            return NSJSONSerialization.dataWithJSONObject(object, options: options, error: nil)
        }
        return nil
    }
}

extension JSON: DebugPrintable {
    public var debugDescription: String {
        if
            let data = self.data(options: .PrettyPrinted),
            let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                return String(string)
        }
        return "Invalid JSON."
    }

}

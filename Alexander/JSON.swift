//
//  JSON.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/24/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public enum Error: ErrorType {
    case InvalidObject
}

public struct JSON {
    
    // MARK: - Initializers
    
    public init(object: AnyObject) {
        self.object = object
    }

    
    // MARK: - Properties
    
    public var object: AnyObject

    public var array: [JSON]? {
        return arrayValue?.map({ JSON(object: $0) })
    }

    public var dictionary: [String: JSON]? {
        return dictionaryValue?.mapValues({ JSON(object: $0) })
    }

    public var arrayValue: [AnyObject]? {
        return object as? [AnyObject]
    }

    public var dictionaryValue: [String: AnyObject]? {
        return object as? [String: AnyObject]
    }

    public subscript(index: Int) -> JSON? {
        return (arrayValue?[index]).map({ JSON(object: $0) })
    }

    public subscript(key: String) -> JSON? {
        return (dictionaryValue?[key]).map({ JSON(object: $0) })
    }

    public var stringValue: String? {
        return object as? String
    }

    public var integerValue: Int? {
        return object as? Int
    }

    public var unsignedIntegerValue: UInt? {
        return object as? UInt
    }

    public var doubleValue: Double? {
        return object as? Double
    }

    public var floatValue: Float? {
        return object as? Float
    }

    public var boolValue: Bool? {
        return object as? Bool
    }
    
    
    // MARK: - Functions

    public func decode<T>(transform: JSON -> T?) -> T? {
        return transform(self)
    }
    
    public func decodeArray<T>(transform: JSON -> T?) -> [T]? {
        return arrayValue?.lazy.map(JSON.init).flatMap(transform)
    }
}

extension JSON {
    public init(data: NSData, options: NSJSONReadingOptions = []) throws {
        self.object = try NSJSONSerialization.JSONObjectWithData(data, options: options)
    }

    public func data(options: NSJSONWritingOptions = []) throws -> NSData {
        if NSJSONSerialization.isValidJSONObject(object) {
            return try NSJSONSerialization.dataWithJSONObject(object, options: options)
        }
        throw Error.InvalidObject
    }
}

extension JSON: CustomDebugStringConvertible {
    public var debugDescription: String {
        if
            let data = try? self.data(.PrettyPrinted),
            let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                return String(string)
        }
        return "Invalid JSON."
    }
}

//
//  JSON.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/24/15.
//  Copyright © 2015 HODINKEE. All rights reserved.
//

import Foundation

enum AlexanderError: ErrorType {
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

    public var intValue: Int? {
        return object as? Int
    }

    public var boolValue: Bool? {
        return object as? Bool
    }
    
    
    // MARK: - Functions

    public func decode<T>(transform: JSON -> T?) -> T? {
        return transform(self)
    }
    
    public func decodeArray<T>(transform: JSON -> T?) -> [T]? {
        return (object as? [AnyObject])?.lazy
            .map(JSON.init)
            .map(transform)
            .flatMap({ $0 })
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
        throw AlexanderError.InvalidObject
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

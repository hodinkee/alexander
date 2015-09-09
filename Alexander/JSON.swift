//
//  JSON.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/24/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Foundation

extension JSON {
    enum Error: ErrorType {
        case InvalidObject
    }
}

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
        return (object as? [AnyObject])?.reduce([T](), combine: { array, element in
            switch transform(JSON(object: element)) {
            case .Some(let object):
                return array + CollectionOfOne(object)
            case .None:
                return array
            }
        })
    }
}

extension JSON {
    public init(data: NSData, options: NSJSONReadingOptions = []) throws {
        do {
            self.object = try NSJSONSerialization.JSONObjectWithData(data, options: options)
        }
        catch {
            throw error
        }
    }

    public func data(options: NSJSONWritingOptions = []) throws -> NSData {
        if NSJSONSerialization.isValidJSONObject(object) {
            do {
                return try NSJSONSerialization.dataWithJSONObject(object, options: options)
            }
            catch {
                throw error
            }
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

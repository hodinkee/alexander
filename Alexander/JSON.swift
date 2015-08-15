//
//  JSON.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/24/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    static func decode(JSON: Alexander.JSON) -> Self?
}

public struct JSON {
    public var object: AnyObject

    public init?(object: AnyObject) {
        if NSJSONSerialization.isValidJSONObject(object) {
            self.object = object
        }
        return nil
    }

    public subscript(index: Int) -> JSON? {
        let array = object as? [AnyObject]
        return (array?[index]).flatMap({ JSON(object: $0) })
    }

    public subscript(key: String) -> JSON? {
        let dictionary = object as? [String: AnyObject]
        return (dictionary?[key]).flatMap({ JSON(object: $0) })
    }

    public var string: String? {
        return object as? String
    }

    public var dictionary: [String: JSON]? {
        let block: ([String: JSON], (String, AnyObject)) -> [String: JSON] = { dictionary, element in
            switch JSON(object: element.1) {
            case .Some(let JSON):
                var mutableDictionary = dictionary
                mutableDictionary[element.0] = JSON
                return mutableDictionary
            case .None:
                return dictionary
            }
        }
        return (object as? [String: AnyObject]).map({ reduce($0, [String: JSON](), block) })
    }

    public var array: [JSON]? {
        let block: ([JSON], AnyObject) -> [JSON] = { array, element in
            switch JSON(object: element) {
            case .Some(let JSON):
                return array + CollectionOfOne(JSON)
            case .None:
                return array
            }
        }
        return (object as? [AnyObject])?.reduce([JSON](), combine: block)
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

    public func decodeArray<T: JSONDecodable>(type: T.Type) -> [T]? {
        return decodeArray(T.decode)
    }

    public func decodeArray<T>(transform: JSON -> T?) -> [T]? {
        let block: ([T], AnyObject) -> [T] = { array, element in
            switch JSON(object: element).flatMap(transform) {
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

    func data(options: NSJSONWritingOptions = .allZeros) -> NSData? {
        return NSJSONSerialization.dataWithJSONObject(object, options: options, error: nil)
    }
}

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

extension Dictionary {
    private func map<T>(transform: Value -> T) -> [Key: T] {
        return reduce(self, [Key: T](), { dictionary, element in
            var mutableDictionary = dictionary
            mutableDictionary[element.0] = transform(element.1)
            return mutableDictionary
        })
    }
}

public struct JSON {
    public var object: AnyObject

    public init?(data: NSData, options: NSJSONReadingOptions = .allZeros) {
        if let object: AnyObject = NSJSONSerialization.JSONObjectWithData(data, options: options, error: nil) {
            self.object = object
        }
        else {
            return nil
        }
    }

    public init(object: AnyObject) {
        self.object = object
    }

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
        return (object as? [String: AnyObject])?.map({ JSON(object: $0) })
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

    public func decodeArray<T: JSONDecodable>(type: T.Type) -> [T]? {
        return array?.reduce([T](), combine: { array, element in
            switch T.decode(element) {
            case .Some(let object):
                return array + CollectionOfOne(object)
            case .None:
                return array
            }
        })
    }
}

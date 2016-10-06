//
//  JSON.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/24/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public struct JSON {

    // MARK: - Properties
    
    let storage: AnyObject


    // MARK: - Initializers

    public init(value: AnyObject) {
        storage = value
    }

    public init(data: NSData, options: NSJSONReadingOptions = []) throws {
        self.init(value: try NSJSONSerialization.JSONObjectWithData(data, options: options))
    }

    public init(stream: NSInputStream, options: NSJSONReadingOptions = []) throws {
        self.init(value: try NSJSONSerialization.JSONObjectWithStream(stream, options: options))
    }

    
    // MARK: - Functions

    public func value() -> Any {
        return storage
    }

    public func value(atIndex index: Int) throws -> JSON {
        let array: [AnyObject] = try value()
        return JSON(value: array[index])
    }

    public func value(forKey key: String) throws -> JSON {
        let dictionary: [String: AnyObject] = try value()
        guard let value = dictionary[key] else {
            throw AlexanderError.keyNotFound(key: key)
        }
        return JSON(value: value)
    }

    public func value<T>() throws -> T {
        guard let value = storage as? T else {
            throw AlexanderError.typeMismatch(expected: T.self, actual: storage)
        }
        return value
    }

    public func value<T>(atIndex index: Int) throws -> T {
        return try value(atIndex: index).value()
    }

    public func value<T>(forKey key: String) throws -> T {
        return try value(forKey: key).value()
    }

    public func value<T>(transform: (JSON) throws -> T) rethrows -> T {
        return try transform(self)
    }

    public func value<T>(atIndex index: Int, transform: (JSON) throws -> T) throws -> T {
        return try transform(try value(atIndex: index))
    }

    public func value<T>(forKey key: String, transform: (JSON) throws -> T) throws -> T {
        return try transform(try value(forKey: key))
    }

    public func data(options: NSJSONWritingOptions = []) throws -> NSData {
        guard NSJSONSerialization.isValidJSONObject(storage) else {
            throw AlexanderError.invalidObject
        }
        return try NSJSONSerialization.dataWithJSONObject(storage, options: options)
    }
}

extension JSON: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard let
            data = try? self.data(.PrettyPrinted),
            string = NSString(data: data, encoding: NSUTF8StringEncoding)
        else {
            return "Invalid JSON."
        }
        return String(string)
    }
}

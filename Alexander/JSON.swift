//
//  JSON.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/24/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public struct JSON {
    
    // MARK: - Initializers
    
    public init(object: Any) {
        self.object = object
    }

    
    // MARK: - Properties
    
    public var object: Any

    public var array: [JSON]? {
        return arrayValue?.map(JSON.init)
    }

    public var dictionary: [String: JSON]? {
        return dictionaryValue?.mapValues(JSON.init)
    }

    public var arrayValue: [Any]? {
        return object as? [Any]
    }

    public var dictionaryValue: [String: Any]? {
        return object as? [String: Any]
    }

    public subscript(index: Int) -> JSON? {
        return (arrayValue?[index]).map(JSON.init)
    }

    public subscript(key: String) -> JSON? {
        return (dictionaryValue?[key]).map(JSON.init)
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

    public func decode<T>(_ transform: (JSON) -> T?) -> T? {
        return transform(self)
    }
    
    public func decodeArray<T>(_ transform: (JSON) -> T?) -> [T]? {
        return arrayValue?.lazy.map(JSON.init).compactMap(transform)
    }
}

extension JSON {
    public init(data: Data, options: JSONSerialization.ReadingOptions = []) throws {
        self.object = try JSONSerialization.jsonObject(with: data, options: options)
    }

    public func data(with options: JSONSerialization.WritingOptions = []) throws -> Data {
        guard JSONSerialization.isValidJSONObject(object) else {
            throw AlexanderError.invalidObject
        }
        return try JSONSerialization.data(withJSONObject: object, options: options)
    }
}

extension JSON: CustomDebugStringConvertible {
    public var debugDescription: String {
        guard
            let data = try? self.data(with: .prettyPrinted),
            let string = String(data: data, encoding: .utf8)
        else {
            return "Invalid JSON."
        }
        return String(string)
    }
}

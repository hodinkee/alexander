//
//  Deprecated.swift
//  Alexander
//
//  Created by Jonathan Baker on 10/6/16.
//  Copyright © 2016 HODINKEE. All rights reserved.
//

import Foundation

extension JSON {

    // MARK: - Deprecated Initalizers

    @available(*, deprecated, message="Use JSON.init(value:) instead.")
    public init(object: AnyObject) {
        storage = object
    }


    // MARK: - Deprecated Properties

    @available(*, deprecated, message="")
    public var object: AnyObject {
        return storage
    }

    @available(*, deprecated, message="")
    public var array: [JSON]? {
        return arrayValue?.map({ JSON.init(value: $0) })
    }

    @available(*, deprecated, message="")
    public var dictionary: [String: JSON]? {
        return dictionaryValue?.mapValues({ JSON.init(value: $0) })
    }

    @available(*, deprecated, message="")
    public var arrayValue: [AnyObject]? {
        return try? value()
    }

    @available(*, deprecated, message="")
    public var dictionaryValue: [String: AnyObject]? {
        return try? value()
    }

    @available(*, deprecated, message="")
    public subscript(index: Int) -> JSON? {
        return (arrayValue?[index]).map({ JSON.init(value: $0) })
    }

    @available(*, deprecated, message="")
    public subscript(key: String) -> JSON? {
        return (dictionaryValue?[key]).map({ JSON.init(value: $0) })
    }

    @available(*, deprecated, message="")
    public var stringValue: String? {
        return try? value()
    }

    @available(*, deprecated, message="")
    public var integerValue: Int? {
        return try? value()
    }

    @available(*, deprecated, message="")
    public var unsignedIntegerValue: UInt? {
        return try? value()
    }

    @available(*, deprecated, message="")
    public var doubleValue: Double? {
        return try? value()
    }

    @available(*, deprecated, message="")
    public var floatValue: Float? {
        return try? value()
    }

    @available(*, deprecated, message="")
    public var boolValue: Bool? {
        return try? value()
    }


    // MARK: - Deprecated Functions

    @available(*, deprecated, message="")
    public func decode<T>(transform: JSON -> T?) -> T? {
        return transform(self)
    }

    @available(*, deprecated, message="")
    public func decodeArray<T>(transform: JSON -> T?) -> [T]? {
        return arrayValue?.lazy.map({ JSON.init(value: $0) }).flatMap(transform)
    }
}

extension AlexanderError {
    @available(*, deprecated, message="Use AlexanderError.invalidObject instead.")
    static let InvalidObject: AlexanderError = .invalidObject
}

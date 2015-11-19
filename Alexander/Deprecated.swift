//
//  Deprecated.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/19/15.
//  Copyright © 2015 Hodinkee. All rights reserved.
//

extension JSON {
    @available(*, deprecated, message = "Use stringValue instead.")
    public var string: String? {
        return stringValue
    }

    @available(*, deprecated, message = "Use intValue instead.")
    public var int: Int? {
        return intValue
    }

    public var double: Double? {
        return object as? Double
    }

    @available(*, deprecated, message = "Use boolValue instead.")
    public var bool: Bool? {
        return boolValue
    }

    @available(*, deprecated, message = "Use decode(NSURLDecoder) instead.")
    public var url: NSURL? {
        return decode(NSURLDecoder)
    }

    @available(*, deprecated, message = "Use decode(NSTimeIntervalDecoder) instead.")
    public var timeInterval: NSTimeInterval? {
        return decode(NSTimeIntervalDecoder)
    }

    @available(*, deprecated, message = "Use decode(NSDateTimeIntervalSince1970Decoder) instead.")
    public var date: NSDate? {
        return decode(NSDateTimeIntervalSince1970Decoder)
    }
}

@available(*, deprecated, message = "Use Alexander.DecoderType instead.")
public protocol JSONDecodable {
    static func decode(JSON: Alexander.JSON) -> Self?
}

public extension Alexander.JSON {
    public func decode<T: JSONDecodable>(type: T.Type) -> T? {
        return decode(T.decode)
    }

    public func decodeArray<T: JSONDecodable>(type: T.Type) -> [T]? {
        return decodeArray(T.decode)
    }

    @available(*, deprecated, message = "Use decode(RawRepresentableDecoder<T>) instead.")
    public func decode<T: RawRepresentable>(type: T.Type) -> T? {
        return decode(RawRepresentableDecoder)
    }

    @available(*, deprecated, message = "Use decode(RawRepresentableDecoder<T>) instead.")
    public func decodeArray<T: RawRepresentable>(type: T.Type) -> [T]? {
        return decodeArray(RawRepresentableDecoder)
    }
}

@available(*, deprecated, message = "Use Alexander.EncoderType instead.")
public protocol JSONEncodable {
    var JSON: Alexander.JSON { get }
}

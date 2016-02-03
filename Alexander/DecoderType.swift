//
//  DecoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/18/15.
//  Copyright © 2015 HODINKEE. All rights reserved.
//

public protocol DecoderType {
    typealias Value
    static func decode(JSON: Alexander.JSON) -> Value?
}

extension JSON {
    public func decode<T: DecoderType>(decoder: T.Type) -> T.Value? {
        return decode(T.decode)
    }

    public func decodeArray<T: DecoderType>(decoder: T.Type) -> [T.Value]? {
        return decodeArray(T.decode)
    }
}

/// Decodes the given `JSON` as a `NSTimeInterval`.
public struct NSTimeIntervalDecoder: DecoderType {
    public static func decode(JSON: Alexander.JSON) -> NSTimeInterval? {
        return JSON.object as? NSTimeInterval
    }
}

/// Decodes the given `JSON` into a `NSDate`.
///
/// - SeeAlso: `NSDate(timeIntervalSince1970:)`
public struct NSDateTimeIntervalSince1970Decoder: DecoderType {
    public static func decode(JSON: Alexander.JSON) -> NSDate? {
        return JSON.decode(NSTimeIntervalDecoder).flatMap({ NSDate(timeIntervalSince1970: $0) })
    }
}

/// Decodes the given `JSON` into a `NSDate`.
///
/// - SeeAlso: `NSDate(timeIntervalSinceReferenceDate:)`
public struct NSDateTimeIntervalSinceReferenceDateDecoder: DecoderType {
    public static func decode(JSON: Alexander.JSON) -> NSDate? {
        return JSON.decode(NSTimeIntervalDecoder).flatMap({ NSDate(timeIntervalSinceReferenceDate: $0) })
    }
}

/// Decodes the given `JSON` into a `NSURL`.
///
/// - SeeAlso: `NSURL(string:)`
public struct NSURLDecoder: DecoderType {
    public static func decode(JSON: Alexander.JSON) -> NSURL? {
        return JSON.stringValue.flatMap({ NSURL(string: $0) })
    }
}

/// Decodes the given `JSON` into a type (`T`) that conforms to `RawRepresentable`.
///
/// For example: `let season = JSON.decode(RawRepresentableDecoder<Season>)`
///
/// - SeeAlso: `RawRepresentable(rawValue:)`
public struct RawRepresentableDecoder<T: RawRepresentable>: DecoderType {
    public static func decode(JSON: Alexander.JSON) -> T? {
        return (JSON.object as? T.RawValue).flatMap({ T(rawValue: $0) })
    }
}

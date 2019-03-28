//
//  DecoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/18/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public protocol DecoderType {
    associatedtype Value
    static func decode(_ JSON: Alexander.JSON) -> Value?
}

extension JSON {

    /// Turn the receiver into a single `T.Value`.
    public func decode<T: DecoderType>(_ decoder: T.Type) -> T.Value? {
        return decode(T.decode)
    }

    /// Turn the receiver into an array of `T.Value`
    public func decodeArray<T: DecoderType>(_ decoder: T.Type) -> [T.Value]? {
        return decodeArray(T.decode)
    }
}

@available(*, deprecated, renamed: "DateTimeIntervalSince1970Decoder")
public struct NSDateTimeIntervalSince1970Decoder: DecoderType {
    public static func decode(_ JSON: Alexander.JSON) -> Date? {
        return DateTimeIntervalSince1970Decoder.decode(JSON)
    }
}

/// Decodes the given `JSON` into a `Date`.
///
/// - SeeAlso: `Date(timeIntervalSince1970:)`
public struct DateTimeIntervalSince1970Decoder: DecoderType {
    public static func decode(_ JSON: Alexander.JSON) -> Date? {
        return (JSON.object as? NSNumber)
            .map({ TimeInterval($0.doubleValue) })
            .flatMap({ Date(timeIntervalSince1970: $0) })
    }
}

@available(*, deprecated, renamed: "DateTimeIntervalSinceReferenceDateDecoder")
public struct NSDateTimeIntervalSinceReferenceDateDecoder: DecoderType {
    public static func decode(_ JSON: Alexander.JSON) -> Date? {
        return DateTimeIntervalSinceReferenceDateDecoder.decode(JSON)
    }
}

/// Decodes the given `JSON` into a `Date`.
///
/// - SeeAlso: `Date(timeIntervalSinceReferenceDate:)`
public struct DateTimeIntervalSinceReferenceDateDecoder: DecoderType {
    public static func decode(_ JSON: Alexander.JSON) -> Date? {
        return (JSON.object as? NSNumber)
            .map({ TimeInterval($0.doubleValue) })
            .flatMap({ Date(timeIntervalSinceReferenceDate: $0) })
    }
}

@available(*, deprecated, renamed: "URLDecoder")
public struct NSURLDecoder: DecoderType {
    public static func decode(_ JSON: Alexander.JSON) -> URL? {
        return URLDecoder.decode(JSON)
    }
}

/// Decodes the given `JSON` into a `URL`.
///
/// - SeeAlso: `URL(string:)`
public struct URLDecoder: DecoderType {
    public static func decode(_ JSON: Alexander.JSON) -> URL? {
        return JSON.stringValue.flatMap({ URL(string: $0) })
    }
}

/// Decodes the given `JSON` into a type (`T`) that conforms to `RawRepresentable`.
///
/// For example: `let season = JSON.decode(RawRepresentableDecoder<Season>)`
///
/// - SeeAlso: `RawRepresentable(rawValue:)`
public struct RawRepresentableDecoder<T: RawRepresentable>: DecoderType {
    public static func decode(_ JSON: Alexander.JSON) -> T? {
        return (JSON.object as? T.RawValue).flatMap({ T(rawValue: $0) })
    }
}

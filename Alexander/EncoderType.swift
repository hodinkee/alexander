//
//  EncoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/19/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public protocol EncoderType {
    associatedtype Value
    static func encode(_ value: Value) -> AnyObject
}

extension EncoderType {
    /// Encode a sequence of values by calling `encode(_:)` with each `Value`
    /// in `sequence`.
    public static func encodeSequence<S: Sequence>(_ sequence: S) -> Any where S.Iterator.Element == Value {
        return sequence.map(encode)
    }

    @available(*, deprecated, message : "Use encodeSequence(_:) instead.")
    public static func encode<S: Sequence>(_ sequence: S) -> Any where S.Iterator.Element == Value {
        return encodeSequence(sequence)
    }
}

/// Encodes the given `NSDate` into a primative `JSON` type.
///
/// - SeeAlso: `NSDate.timeIntervalSince1970`
public struct NSDateTimeIntervalSince1970Encoder: EncoderType {
    public static func encode(_ value: Date) -> AnyObject {
        return value.timeIntervalSince1970 as AnyObject
    }
}

/// Encodes the given `NSDate` into a primative `JSON` type.
///
/// - SeeAlso: `NSDate.timeIntervalSinceReferenceDate`
public struct NSDateTimeIntervalSinceReferenceDateEncoder: EncoderType {
    public static func encode(_ value: Date) -> AnyObject {
        return value.timeIntervalSinceReferenceDate as AnyObject
    }
}

/// Encodes the given `NSURL` into a primative `JSON` type.
///
/// - SeeAlso: `NSURL.absoluteString`
public struct NSURLEncoder: EncoderType {
    public static func encode(_ value: URL) -> AnyObject {
        #if swift(>=2.3)
            return value.absoluteString as AnyObject? ?? NSNull()
        #else
            return value.absoluteString
        #endif
    }
}

//
//  EncoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/19/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public protocol EncoderType {
    typealias Value
    static func encode(value: Value) -> AnyObject
}

extension EncoderType {
    /// Encode a sequence of values by calling `encode(_:)` with each `Value`
    /// in `sequence`.
    public static func encodeSequence<S: SequenceType where S.Generator.Element == Value>(sequence: S) -> AnyObject {
        return sequence.map(encode)
    }

    @available(*, deprecated, message = "Use encodeSequence(_:) instead.")
    public static func encode<S: SequenceType where S.Generator.Element == Value>(sequence: S) -> AnyObject {
        return encodeSequence(sequence)
    }
}

/// Encodes the given `NSDate` into a primative `JSON` type.
///
/// - SeeAlso: `NSDate.timeIntervalSince1970`
public struct NSDateTimeIntervalSince1970Encoder: EncoderType {
    public static func encode(value: NSDate) -> AnyObject {
        return value.timeIntervalSince1970
    }
}

/// Encodes the given `NSDate` into a primative `JSON` type.
///
/// - SeeAlso: `NSDate.timeIntervalSinceReferenceDate`
public struct NSDateTimeIntervalSinceReferenceDateEncoder: EncoderType {
    public static func encode(value: NSDate) -> AnyObject {
        return value.timeIntervalSinceReferenceDate
    }
}

/// Encodes the given `NSURL` into a primative `JSON` type.
///
/// - SeeAlso: `NSURL.absoluteString`
public struct NSURLEncoder: EncoderType {
    public static func encode(value: NSURL) -> AnyObject {
        return value.absoluteString
    }
}

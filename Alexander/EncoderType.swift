//
//  EncoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/19/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

@available(*, deprecated, message="")
public protocol EncoderType {
    associatedtype Value
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
@available(*, deprecated, message="")
public struct NSDateTimeIntervalSince1970Encoder: EncoderType {
    public static func encode(value: NSDate) -> AnyObject {
        return value.timeIntervalSince1970
    }
}

/// Encodes the given `NSDate` into a primative `JSON` type.
///
/// - SeeAlso: `NSDate.timeIntervalSinceReferenceDate`
@available(*, deprecated, message="")
public struct NSDateTimeIntervalSinceReferenceDateEncoder: EncoderType {
    public static func encode(value: NSDate) -> AnyObject {
        return value.timeIntervalSinceReferenceDate
    }
}

/// Encodes the given `NSURL` into a primative `JSON` type.
///
/// - SeeAlso: `NSURL.absoluteString`
@available(*, deprecated, message="")
public struct NSURLEncoder: EncoderType {
    public static func encode(value: NSURL) -> AnyObject {
        #if swift(>=2.3)
            return value.absoluteString ?? NSNull()
        #else
            return value.absoluteString
        #endif
    }
}

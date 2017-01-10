//
//  EncoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/19/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public protocol EncoderType {
    associatedtype Value
    static func encode(_ value: Value) -> Any
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

/// Encodes the given `Date` into a primative `JSON` type.
///
/// - SeeAlso: `Date.timeIntervalSince1970`
public struct DateTimeIntervalSince1970Encoder: EncoderType {
    public static func encode(_ value: Date) -> Any {
        return value.timeIntervalSince1970
    }
}

/// Encodes the given `Date` into a primative `JSON` type.
///
/// - SeeAlso: `Date.timeIntervalSinceReferenceDate`
public struct DateTimeIntervalSinceReferenceDateEncoder: EncoderType {
    public static func encode(_ value: Date) -> Any {
        return value.timeIntervalSinceReferenceDate
    }
}

/// Encodes the given `URL` into a primative `JSON` type.
///
/// - SeeAlso: `URL.absoluteString`
public struct URLEncoder: EncoderType {
    public static func encode(_ value: URL) -> Any {
        return value.absoluteString
    }
}

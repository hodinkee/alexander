//
//  EncoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/19/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

public protocol EncoderType {
    typealias Value
    static func encode(value: Value) -> JSON
}

/// Encodes the given `NSDate` into a primative `JSON` type.
///
/// - SeeAlso: `NSDate.timeIntervalSince1970`
public struct NSDateTimeIntervalSince1970Encoder: EncoderType {
    public typealias Value = NSDate
    public static func encode(value: NSDate) -> JSON {
        return JSON(object: value.timeIntervalSince1970)
    }
}

/// Encodes the given `NSDate` into a primative `JSON` type.
///
/// - SeeAlso: `NSDate.timeIntervalSinceReferenceDate`
public struct NSDateTimeIntervalSinceReferenceDateEncoder: EncoderType {
    public typealias Value = NSDate
    public static func encode(value: NSDate) -> JSON {
        return JSON(object: value.timeIntervalSinceReferenceDate)
    }
}

/// Encodes the given `NSURL` into a primative `JSON` type.
///
/// - SeeAlso: `NSURL.absoluteString`
public struct NSURLEncoder: EncoderType {
    public typealias Value = NSURL
    public static func encode(value: NSURL) -> JSON {
        return JSON(object: value.absoluteString)
    }
}

extension EncoderType {
    public static func encode<S: SequenceType where S.Generator.Element == Value>(sequence: S) -> JSON {
        return JSON(object: sequence.map({ encode($0).object }))
    }
}

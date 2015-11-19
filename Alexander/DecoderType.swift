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

public struct NSTimeIntervalDecoder: DecoderType {
    public typealias Value = NSTimeInterval
    public static func decode(JSON: Alexander.JSON) -> Value? {
        return JSON.object as? NSTimeInterval
    }
}

public struct NSDateTimeIntervalSince1970Decoder: DecoderType {
    public typealias Value = NSDate
    public static func decode(JSON: Alexander.JSON) -> Value? {
        return NSTimeIntervalDecoder.decode(JSON).flatMap({ NSDate(timeIntervalSince1970: $0) })
    }
}

public struct NSDateTimeIntervalSinceReferenceDateDecoder: DecoderType {
    public typealias Value = NSDate
    public static func decode(JSON: Alexander.JSON) -> Value? {
        return NSTimeIntervalDecoder.decode(JSON).flatMap({ NSDate(timeIntervalSinceReferenceDate: $0) })
    }
}

public struct NSURLDecoder: DecoderType {
    public typealias Value = NSURL
    public static func decode(JSON: Alexander.JSON) -> Value? {
        return JSON.stringValue.flatMap({ NSURL(string: $0) })
    }
}

public struct RawRepresentableDecoder<T: RawRepresentable>: DecoderType {
    public typealias Value = T
    public static func decode(JSON: Alexander.JSON) -> Value? {
        return (JSON.object as? T.RawValue).flatMap(T.init)
    }
}

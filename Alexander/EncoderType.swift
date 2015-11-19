//
//  EncoderType.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/19/15.
//  Copyright © 2015 HODINKEE. All rights reserved.
//

public protocol EncoderType {
    typealias Value
    static func encode(value: Value) -> JSON
}

public struct NSDateTimeIntervalSince1970Encoder: EncoderType {
    public typealias Value = NSDate
    public static func encode(value: NSDate) -> JSON {
        return JSON(object: value.timeIntervalSince1970)
    }
}

public struct NSDateTimeIntervalSinceReferenceDateEncoder: EncoderType {
    public typealias Value = NSDate
    public static func encode(value: NSDate) -> JSON {
        return JSON(object: value.timeIntervalSinceReferenceDate)
    }
}

public struct NSURLEncoder: EncoderType {
    public typealias Value = NSURL
    public static func encode(value: NSURL) -> JSON {
        return JSON(object: value.absoluteString)
    }
}

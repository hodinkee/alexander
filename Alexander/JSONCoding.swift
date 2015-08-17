//
//  JSONCoding.swift
//  Alexander
//
//  Created by Caleb Davenport on 8/17/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

public protocol JSONEncodable {
    var JSON: Alexander.JSON { get }
}

public protocol JSONDecodable {
    static func decode(JSON: Alexander.JSON) -> Self?
}

public extension Alexander.JSON {
    public func decodeArray<T: JSONDecodable>(type: T.Type) -> [T]? {
        return decodeArray(T.decode)
    }
}

public protocol JSONCoding: JSONEncodable, JSONDecodable {}

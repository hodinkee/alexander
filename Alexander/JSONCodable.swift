//
//  JSONCodable.swift
//  Alexander
//
//  Created by Jonathan Baker on 8/6/15.
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

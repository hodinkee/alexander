//
//  JSONDecodable.swift
//  Alexander
//
//  Created by Jonathan Baker on 10/6/16.
//  Copyright © 2016 HODINKEE. All rights reserved.
//

import Foundation

public protocol JSONDecodable {
    init(json: JSON) throws
}

extension JSON {
    public func value<T: JSONDecodable>() throws -> T {
        return try T.init(json: self)
    }

    public func value<T: JSONDecodable>(atIndex index: Int) throws -> T {
        return try value(atIndex: index).value()
    }

    public func value<T: JSONDecodable>(forKey key: String) throws -> T {
        return try value(forKey: key).value()
    }
}

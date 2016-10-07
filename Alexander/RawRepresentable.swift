//
//  RawRepresentable.swift
//  Alexander
//
//  Created by Jonathan Baker on 10/7/16.
//  Copyright © 2016 HODINKEE. All rights reserved.
//

import Foundation

extension JSON {
    public func value<T: RawRepresentable>() throws -> T? {
        return T.init(rawValue: try value())
    }

    public func value<T: RawRepresentable>(atIndex index: Int) throws -> T? {
        return try value(atIndex: index).value()
    }

    public func value<T: RawRepresentable>(forKey key: String) throws -> T? {
        return try value(forKey: key).value()
    }
}

//
//  JSONEncodable.swift
//  Alexander
//
//  Created by Jonathan Baker on 8/6/15.
//  Copyright (c) 2015 Hodinkee. All rights reserved.
//

import Foundation

public protocol JSONEncodable {
    var JSON: AnyObject? { get }
}

public extension Alexander.JSON {
    public init?(encodable: JSONEncodable) {
        if let object: AnyObject = encodable.JSON {
            self.object = object
        }
        else {
            return nil
        }
    }
}

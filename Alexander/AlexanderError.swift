//
//  AlexanderError.swift
//  Alexander
//
//  Created by Caleb Davenport on 6/15/16.
//  Copyright © 2016 HODINKEE. All rights reserved.
//

public enum AlexanderError: ErrorType {
    case invalidObject
    case keyNotFound(key: String)
    case typeMismatch(expected: Any.Type, actual: Any)
}

extension AlexanderError: CustomStringConvertible {
    public var description: String {
        switch self {
        case .invalidObject:
            return "AlexanderError.invalidObject"
        case .keyNotFound(let key):
            return "AlexanderError.keyNotFound: The value for key \"\(key)\" could not be found."
        case .typeMismatch(let expected, let actual):
            return "AlexanderError.typeMismatch: Expected \(expected) but found \(actual.dynamicType)(\(actual))."
        }
    }
}

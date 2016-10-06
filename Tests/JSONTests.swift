//
//  JSONTests.swift
//  Alexander
//
//  Created by Jonathan Baker on 10/6/16.
//  Copyright © 2016 HODINKEE. All rights reserved.
//

import XCTest
@testable import Alexander

final class JSONTests: XCTestCase {
    func testKeyNotFoundError() {
        let json = JSON(value: ["hello": "world"])

        XCTAssertThrowsError(try json.value(forKey: "foo")) { error in
            guard case AlexanderError.keyNotFound = error else {
                XCTFail(); return
            }
        }
    }

    func testTypeMismatchError() {
        let json = JSON(value: ["hello": "world"])

        XCTAssertThrowsError(try json.value(forKey: "hello") as Int) { error in
            guard case AlexanderError.typeMismatch = error else {
                XCTFail(); return
            }
        }
    }
}

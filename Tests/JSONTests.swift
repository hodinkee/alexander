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
    func testTypeInference() {
        let json = JSON(value: [
            "string": "hello",
            "integer": 1234,
            "boolean": true,
            "string-array": [
                "one", "two", "three"
            ]
        ])

        do {
            let aString: String = try json.value(forKey: "string")
            let anInteger: Int = try json.value(forKey: "integer")
            let aBoolean: Bool = try json.value(forKey: "boolean")
            let anArray: [String] = try json.value(forKey: "string-array")

            XCTAssertEqual(aString, "hello")
            XCTAssertEqual(anInteger, 1234)
            XCTAssertEqual(aBoolean, true)
            XCTAssertEqual(anArray, ["one", "two", "three"])
        }
        catch {
            XCTFail("\(error)")
        }
    }

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

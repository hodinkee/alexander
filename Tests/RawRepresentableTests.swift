//
//  RawRepresentableTests.swift
//  Alexander
//
//  Created by Jonathan Baker on 10/7/16.
//  Copyright © 2016 HODINKEE. All rights reserved.
//

import XCTest
@testable import Alexander

final class RawRepresentableTests: XCTestCase {

    private enum Season: String {
        case winter
        case spring
        case summer
        case fall
    }

    func testRawRepresentableValue() {
        let json = JSON(value: "summer")
        XCTAssertEqual(try json.value(), Season.summer)
    }

    func testRawRepresentableValueAtIndex() {
        let json = JSON(value: ["winter", "spring", "fall"])
        XCTAssertEqual(try json.value(atIndex: 1), Season.spring)
    }

    func testRawRepresentableValueForKey() {
        let json = JSON(value: ["season": "winter"])
        XCTAssertEqual(try json.value(forKey: "season"), Season.winter)
    }
}

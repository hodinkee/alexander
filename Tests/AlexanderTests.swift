//
//  AlexanderTests.swift
//  Alexander Tests
//
//  Created by Caleb Davenport on 11/18/15.
//  Copyright © 2015 HODINKEE. All rights reserved.
//

import XCTest
import Alexander

final class AlexanderTests: XCTestCase {
    func testArray() {
        let JSON = Alexander.JSON(object: ["1","2", "a", "B", "D"])
        XCTAssertEqual(JSON.array?.count, 5)
        XCTAssertEqual(JSON[0]?.stringValue, "1")
        XCTAssertEqual(JSON[1]?.stringValue, "2")
        XCTAssertEqual(JSON[2]?.stringValue, "a")
        XCTAssertEqual(JSON[3]?.stringValue, "B")
        XCTAssertEqual(JSON[4]?.stringValue, "D")
    }

    func testDictionary() {
        let dictionary = [
            "double": 9823.212,
            "int": 42,
            "string": "Caleb",
            "array": [ 1234, 4.212 ],
            "object": [
                "double": 877.2323,
                "string": "Jon"
            ],
            "bool": true
        ]

        let JSON = Alexander.JSON(object: dictionary)

        XCTAssertEqual(JSON["double"]?.double, 9823.212)
        XCTAssertEqual(JSON["int"]?.intValue, 42)
        XCTAssertEqual(JSON["string"]?.stringValue, "Caleb")
        XCTAssertEqual(JSON["bool"]?.boolValue, true)

        XCTAssertEqual(JSON["array"]?.array?.count, 2)
        XCTAssertEqual(JSON["array"]?[0]?.double, 1234)
        XCTAssertEqual(JSON["array"]?[1]?.double, 4.212)

        XCTAssertEqual(JSON["object"]?.dictionary?.count, 2)
        XCTAssertEqual(JSON["object"]?["double"]?.double, 877.2323)
        XCTAssertEqual(JSON["object"]?["string"]?.stringValue, "Jon")

        XCTAssertNil(JSON["null"])
    }

    func testDecodeRawRepresentableSingle() {
        enum Season: String {
            case Winter = "winter"
            case Spring = "spring"
            case Summer = "summer"
            case Fall = "fall"
        }

        XCTAssertEqual(JSON(object: "summer").decode(RawRepresentableDecoder<Season>), .Summer)
        XCTAssertNil(JSON(object: "wrong").decode(RawRepresentableDecoder<Season>))
    }

    func testDecodeRawRepresentableArray() {
        enum Season: String {
            case Winter = "winter"
            case Spring = "spring"
            case Summer = "summer"
            case Fall = "fall"
        }

        let seasons = [ "winter", "summer", "spring", "wrong" ]
        let JSON = Alexander.JSON(object: seasons)
        guard let decodedSeasons = JSON.decodeArray(RawRepresentableDecoder<Season>) else {
            XCTFail()
            return
        }

        XCTAssertEqual(decodedSeasons.count, 3)
        XCTAssertEqual(decodedSeasons, [ Season.Winter, Season.Summer, Season.Spring ])
    }

    func testURLHelpers() {
        let JSON = Alexander.JSON(object: "https://www.hodinkee.com")

        guard let URL = JSON.decode(NSURLDecoder) else {
            XCTFail()
            return
        }

        XCTAssertEqual(URL, NSURL(string: "https://www.hodinkee.com"))
    }

    func testDateHelpers() {
        let JSON = Alexander.JSON(object: 978307200)
        XCTAssertEqual(JSON.decode(NSTimeIntervalDecoder), NSDate(timeIntervalSinceReferenceDate: 0).timeIntervalSince1970)
        XCTAssertEqual(JSON.decode(NSDateTimeIntervalSince1970Decoder), NSDate(timeIntervalSinceReferenceDate: 0))
    }
}

//
//  AlexanderTests.swift
//  Alexander
//
//  Created by Caleb Davenport on 11/18/15.
//  Copyright © 2015 Hodinkee. All rights reserved.
//

import XCTest
import Alexander

final class AlexanderTests: XCTestCase {

    func testArray() {
        let JSON = Alexander.JSON(object: ["1","2", "a", "B", "D"])
        XCTAssertEqual(JSON.array?.count, 5)
        XCTAssertEqual(JSON[0]?.string, "1")
        XCTAssertEqual(JSON[1]?.string, "2")
        XCTAssertEqual(JSON[2]?.string, "a")
        XCTAssertEqual(JSON[3]?.string, "B")
        XCTAssertEqual(JSON[4]?.string, "D")
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
        XCTAssertEqual(JSON["int"]?.int, 42)
        XCTAssertEqual(JSON["string"]?.string, "Caleb")
        XCTAssertEqual(JSON["bool"]?.bool, true)

        XCTAssertEqual(JSON["array"]?.array?.count, 2)
        XCTAssertEqual(JSON["array"]?[0]?.double, 1234)
        XCTAssertEqual(JSON["array"]?[1]?.double, 4.212)

        XCTAssertEqual(JSON["object"]?.dictionary?.count, 2)
        XCTAssertEqual(JSON["object"]?["double"]?.double, 877.2323)
        XCTAssertEqual(JSON["object"]?["string"]?.string, "Jon")

        XCTAssertNil(JSON["null"])
    }

    func testDecodeRawRepresentableSingle() {
        enum Season: String {
            case Winter = "winter"
            case Spring = "spring"
            case Summer = "summer"
            case Fall = "fall"
        }

        XCTAssertEqual(JSON(object: "summer").decode(Season), .Summer)
        XCTAssertNil(JSON(object: "wrong").decode(Season))
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
        guard let decodedSeasons = JSON.decodeArray(Season) else {
            XCTFail()
            return
        }

        XCTAssertEqual(decodedSeasons.count, 3)
        XCTAssertEqual(decodedSeasons, [ Season.Winter, Season.Summer, Season.Spring ])
    }

    func testValidDecodableObjectSingle() {
        struct User: JSONDecodable {
            var ID: String
            var name: String

            static func decode(JSON: Alexander.JSON) -> User? {
                guard let ID = JSON["id"]?.string, let name = JSON["name"]?.string else {
                    return nil
                }
                return User(ID: ID, name: name)
            }
        }

        let user = User(ID: "1", name: "Caleb")
        let object = [ "id": user.ID, "name": user.name ]
        let JSON = Alexander.JSON(object: object)
        guard let decodedUser = JSON.decode(User) else {
            XCTFail()
            return
        }

        XCTAssertEqual(decodedUser.ID, user.ID)
        XCTAssertEqual(decodedUser.name, user.name)
    }

    func testValidDecodableObjectArray() {
        struct User: JSONDecodable {
            var ID: String
            var name: String

            static func decode(JSON: Alexander.JSON) -> User? {
                guard let ID = JSON["id"]?.string, let name = JSON["name"]?.string else {
                    return nil
                }
                return User(ID: ID, name: name)
            }
        }

        let users = [
            User(ID: "1", name: "Caleb"),
            User(ID: "2", name: "Jon")
        ]
        let object = [
            "users": [
                [ "id": users[0].ID, "name": users[0].name ],
                [ "id": users[1].ID, "name": users[1].name ]
            ]
        ]
        let JSON = Alexander.JSON(object: object)
        guard let decodedUsers = JSON["users"]?.decodeArray(User) else {
            XCTFail()
            return
        }

        XCTAssertEqual(decodedUsers.count, 2)

        XCTAssertEqual(decodedUsers[0].ID, users[0].ID)
        XCTAssertEqual(decodedUsers[0].name, users[0].name)

        XCTAssertEqual(decodedUsers[1].ID, users[1].ID)
        XCTAssertEqual(decodedUsers[1].name, users[1].name)
    }

    func testURLHelpers() {
        let JSON = Alexander.JSON(object: "https://www.hodinkee.com")
        let URL = JSON.url
        XCTAssertNotNil(URL)
        XCTAssertEqual(URL, NSURL(string: "https://www.hodinkee.com"))
    }

    func testDateHelpers() {
        let JSON = Alexander.JSON(object: 978307200)
        XCTAssertEqual(JSON.timeInterval, NSDate(timeIntervalSinceReferenceDate: 0).timeIntervalSince1970)
        XCTAssertEqual(JSON.date, NSDate(timeIntervalSinceReferenceDate: 0))
    }
}

//
//  UserDecoderTests.swift
//  Alexander Tests
//
//  Created by Caleb Davenport on 11/18/15.
//  Copyright © 2015-2016 HODINKEE. All rights reserved.
//

import XCTest
import Alexander

final class UserDecoderTests: XCTestCase {
    func testDecodeValidUser() {
        let user = User(ID: "1", name: "Caleb")
        let object = [ "id": user.ID, "name": user.name ]
        let JSON = Alexander.JSON(object: object)
        guard let decodedUser = JSON.decode(UserDecoder) else {
            XCTFail()
            return
        }

        XCTAssertEqual(decodedUser.ID, user.ID)
        XCTAssertEqual(decodedUser.name, user.name)
    }

    func testDecodeValidUsersArray() {
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
        guard let decodedUsers = JSON["users"]?.decodeArray(UserDecoder) else {
            XCTFail()
            return
        }

        XCTAssertEqual(decodedUsers.count, 2)

        XCTAssertEqual(decodedUsers[0].ID, users[0].ID)
        XCTAssertEqual(decodedUsers[0].name, users[0].name)

        XCTAssertEqual(decodedUsers[1].ID, users[1].ID)
        XCTAssertEqual(decodedUsers[1].name, users[1].name)
    }
}

struct User {
    var ID: String
    var name: String
}

struct UserDecoder: DecoderType {
    typealias Value = User
    static func decode(JSON: Alexander.JSON) -> Value? {
        guard let ID = JSON["id"]?.stringValue, let name = JSON["name"]?.stringValue else {
            return nil
        }
        return User(ID: ID, name: name)
    }
}

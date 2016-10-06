//
//  JSONDecodableTests.swift
//  Alexander
//
//  Created by Jonathan Baker on 10/6/16.
//  Copyright © 2016 HODINKEE. All rights reserved.
//

import XCTest
@testable import Alexander

final class JSONDecodableTests: XCTestCase {

    private struct Author: JSONDecodable {
        var name: String

        var biography: String?

        var articles: [Article]

        init(json: JSON) throws {
            name = try json.value(forKey: "name")
            biography = try? json.value(forKey: "biography")
            articles = try json.value(forKey: "articles")
        }
    }

    private struct Article: JSONDecodable {
        var id: Int

        var title: String

        init(json: JSON) throws {
            id = try json.value(forKey: "id")
            title = try json.value(forKey: "title")
        }
    }

    func testAuthorDecodable() {
        let json = JSON(value: [
            "author": [
                "name": "John Doe",
                "articles": [
                    ["id": 1, "title": "Computer Science 101"],
                    ["id": 2, "title": "Computer Science 201"],
                    ["id": 3, "title": "Computer Science 301"]
                ]
            ]
        ])

        do {
            let author: Author = try json.value(forKey: "author")
            print(author)
            XCTAssertNil(author.biography)
            XCTAssertEqual(author.name, "John Doe")
            XCTAssertEqual(author.articles.count, 3)
            XCTAssertEqual(author.articles[1].title, "Computer Science 201")
        }
        catch {
            XCTFail("Error: \(error)")
        }
    }
}

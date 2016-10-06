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

    private struct Article: JSONDecodable {
        var id: Int

        var title: String

        var author: Author

        init(json: JSON) throws {
            id = try json.value(forKey: "id")
            title = try json.value(forKey: "title")
            author = try json.value(forKey: "author")
        }
    }

    private struct Author: JSONDecodable {
        var name: String

        var biography: String?

        init(json: JSON) throws {
            name = try json.value(forKey: "name")
            biography = try? json.value(forKey: "biography")
        }
    }

    func testArticleDecodable() {
        let json = JSON(value: [
            "article": [
                "id": 1337,
                "title": "Hello World",
                "author": [
                    "name": "John Doe"
                ]
            ]
        ])

        do {
            let article: Article = try json.value(forKey: "article")
            XCTAssertEqual(article.id, 1337)
            XCTAssertEqual(article.title, "Hello World")
            XCTAssertEqual(article.author.name, "John Doe")
            XCTAssertNil(article.author.biography)
        }
        catch {
            XCTFail()
        }
    }
}

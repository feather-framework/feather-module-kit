//
//  File.swift
//
//
//  Created by Tibor Bodecs on 04/02/2024.
//

import XCTest

@testable import FeatherModuleKit

final class FeatherModuleKitTests: XCTestCase {

    func testID() async throws {

        let rawId = "foo-id"

        struct Foo: Identifiable, Identified {
            var id: ID<Self>
        }

        let foo = Foo(id: .init(rawValue: rawId))

        XCTAssertEqual(foo.id, ID<Foo>(rawValue: rawId))
        XCTAssertEqual(foo.id.rawValue, rawId)
    }

    func testID2() async throws {

        let rawId = "foo-id"

        enum Feather {
            enum Core: Identifiable {

            }
        }

        struct Foo: Identified {
            var id: ID<Feather.Core>
        }

        let foo = Foo(id: .init(rawValue: rawId))

        XCTAssertEqual(foo.id, ID<Feather.Core>(rawValue: rawId))
        XCTAssertEqual(foo.id.rawValue, rawId)
    }

    func testListConstruction() async throws {

        struct MyList: ListInterface, Pagination, Countable {
            var items: [String]
            var count: UInt
            var page: Page
        }
    }

    func testBasicQueryConstruction() async throws {

        enum MyListSortKeys: SortKeyInterface {
            case foo
        }

        struct MyListSort: Sortable {
            var by: MyListSortKeys
            var order: Order
        }

        struct MyListQuery: SimpleQueryInterface {
            var search: String?
            var sort: MyListSort
            var page: Page
        }
    }

    func testSimpleListConstruction() async throws {

        enum MyListSortKeys: SortKeyInterface {
            case foo
        }

        struct MyListSort: Sortable {
            var by: MyListSortKeys
            var order: Order
        }

        struct MySimpleListQuery: SimpleQueryInterface {
            var search: String?
            var sort: MyListSort
            var page: Page
        }

        struct MySimpleList: SimpleList {
            var query: MySimpleListQuery
            var items: [String]
            var page: Page
            var count: UInt
        }

        let _: (MySimpleListQuery) -> MySimpleList
    }

}

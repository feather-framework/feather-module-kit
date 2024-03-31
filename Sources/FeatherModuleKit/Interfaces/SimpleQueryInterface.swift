//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

public protocol SimpleQueryInterface: Object {
    associatedtype Sort: Sortable
    associatedtype Page: PageInterface

    var search: String? { get }
    var sort: Sort { get }
    var page: Page { get }
}

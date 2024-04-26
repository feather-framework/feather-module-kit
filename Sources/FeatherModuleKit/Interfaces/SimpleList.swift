//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

public protocol SimpleList: ListInterface, Pagination, Countable {
    associatedtype Query: SimpleQueryInterface

    var query: Query { get }
}

//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

public protocol Sortable: Object {
    associatedtype Key: SortKeyInterface

    var by: Key { get }
    var order: Order { get }
}

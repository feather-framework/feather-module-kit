//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol ListAdapter
where Model == Item.Model {
    associatedtype Model: DatabaseModel
    associatedtype Query: ListQueryInterface
    associatedtype Item: ListItemAdapter

    init(items: [Model], count: UInt) throws
    init(items: [Item], count: UInt) throws
}

extension ListAdapter {
    public init(items: [Model], count: UInt) throws {
        try self.init(
            items: try items.map {
                try .init(model: $0)
            },
            count: count
        )
    }
}

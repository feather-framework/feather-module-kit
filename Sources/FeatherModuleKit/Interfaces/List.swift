//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

public protocol List: Object {
    associatedtype ItemType

    var items: [ItemType] { get }
}

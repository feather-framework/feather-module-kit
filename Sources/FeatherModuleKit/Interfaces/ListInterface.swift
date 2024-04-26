//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

public protocol ListInterface: Object {
    associatedtype ItemType

    var items: [ItemType] { get }
}

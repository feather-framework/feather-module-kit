//
//  File.swift
//  
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol ListInterface {
    associatedtype Model: DatabaseModel
    associatedtype Query: ListQueryInterface

    init(items: [Model], count: UInt) throws
}

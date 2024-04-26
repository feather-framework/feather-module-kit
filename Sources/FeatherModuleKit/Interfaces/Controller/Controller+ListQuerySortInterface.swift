//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol ListQuerySortInterface {
    associatedtype Key: SortKeyInterface
    var by: Key { get }
    var order: Order { get }
}

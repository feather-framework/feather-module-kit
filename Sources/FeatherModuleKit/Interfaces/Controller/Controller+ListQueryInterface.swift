//
//  File.swift
//  
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol ListQueryInterface {
    associatedtype Sort: ListQuerySortInterface
    var search: String? { get }
    var page: Page { get }
    var sort: Sort { get }
}

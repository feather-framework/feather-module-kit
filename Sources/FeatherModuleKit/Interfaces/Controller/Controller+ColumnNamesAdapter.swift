//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

public protocol ColumnNamesAdapter {
    associatedtype ListQuerySortKeys: SortKeyInterface
    init(listQuerySortKeys: ListQuerySortKeys) throws
}

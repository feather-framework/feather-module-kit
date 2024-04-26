//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

public protocol ListQuerySortKeyAdapter {
    associatedtype ListQuerySortKeys: SortKeyInterface
    init(listQuerySortKeys: ListQuerySortKeys) throws
}

//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ListQuerySortInterface {
    associatedtype Key: SortKeyInterface
    var by: Key { get }
    var order: Order { get }
}

public protocol ListQueryInterface {
    associatedtype Sort: ListQuerySortInterface
    var search: String? { get }
    var page: Page { get }
    var sort: Sort { get }
}

public protocol ListInterface {
    associatedtype Model: DatabaseModel
    associatedtype Query: ListQueryInterface

    init(items: [Model], count: UInt) throws
}

public protocol ModelColumnNamesInterface {
    associatedtype ListQuerySortKeys: SortKeyInterface
    init(listQuerySortKeys: ListQuerySortKeys) throws
}

public protocol ControllerList: ControllerInterface
where
    Query: DatabaseQueryList,
    List.Model == Model,
    Model.ColumnNames: ModelColumnNamesInterface,
    Model.ColumnNames.ListQuerySortKeys == List.Query.Sort.Key
{
    associatedtype List: ListInterface

    func list(
        _ input: List.Query
    ) async throws -> List

    static var listFilterColumns: [Model.ColumnNames] { get }
}

extension ControllerList {
    public func list(
        _ input: List.Query
    ) async throws -> List {
        let db = try await components.database().connection()

        let filterGroup = input.search.flatMap { value in
            DatabaseGroupFilter<Model.ColumnNames>(
                relation: .or,
                columns: Self.listFilterColumns
                    .map {
                        .init(column: $0, operator: .like, value: "%\(value)%")
                    }
            )
        }

        let result = try await Query.list(
            .init(
                page: .init(
                    size: input.page.size,
                    index: input.page.index
                ),
                orders: [
                    .init(
                        column: .init(listQuerySortKeys: input.sort.by),
                        direction: input.sort.order.queryDirection
                    )
                ],
                filter: filterGroup.map { .init(groups: [$0]) }
            ),
            on: db
        )

        return try .init(items: result.items, count: result.total)
    }
}

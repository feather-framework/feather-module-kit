//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol DetailInterface {
    associatedtype Model: DatabaseModel
    init(model: Model) throws
}

public protocol ControllerGet: KeyedControllerInterface
where
    Query: DatabaseQueryGet,
    Detail.Model == Model
{
    associatedtype Detail: DetailInterface

    func get(
        key: ID<KeyType>
    ) async throws -> Detail
}

extension ControllerGet {
    public func get(
        key: ID<KeyType>
    ) async throws -> Detail {
        let db = try await components.database().connection()
        let model = try await Query.require(key.toKey(), on: db)

        return try .init(model: model)
    }
}

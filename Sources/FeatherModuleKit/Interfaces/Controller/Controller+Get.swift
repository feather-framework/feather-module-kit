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
        _ id: ID<KeyType>
    ) async throws -> Detail

    func getDefault(
        _ id: ID<KeyType>
    ) async throws -> Detail

    static func typeDefinition(detail: Detail.Type)
}

extension ControllerGet {
    public static func typeDefinition(detail: Detail.Type) {}

    public func get(
        _ id: ID<KeyType>
    ) async throws -> Detail {
        try await getDefault(id)
    }

    public func getDefault(
        _ id: ID<KeyType>
    ) async throws -> Detail {
        let db = try await components.database().connection()
        let model = try await Query.require(id.toKey(), on: db)

        return try .init(model: model)
    }
}

//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ReferenceInterface {
    associatedtype Model: DatabaseModel
    init(model: Model) throws
}

public protocol ControllerReference: KeyedControllerInterface
where
    Query: DatabaseQueryListAll,
    Reference.Model == Model
{
    associatedtype Reference: ReferenceInterface

    func reference(
        ids: [ID<KeyType>]
    ) async throws -> [Reference]

    func referenceDefault(
        ids: [ID<KeyType>]
    ) async throws -> [Reference]

    static func typeDefinition(reference: Reference.Type)
}

extension ControllerReference {
    public static func typeDefinition(reference: Reference.Type) {}

    public func reference(
        ids: [ID<KeyType>]
    ) async throws -> [Reference] {
        try await referenceDefault(ids: ids)
    }

    public func referenceDefault(
        ids: [ID<KeyType>]
    ) async throws -> [Reference] {
        let db = try await components.database().connection()

        return
            try await Query
            .listAll(
                filter: .init(
                    column: Model.keyName,
                    operator: .in,
                    value: ids
                ),
                on: db
            )
            .map {
                try .init(model: $0)
            }
    }
}

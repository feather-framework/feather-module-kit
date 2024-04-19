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
        keys: [ID<KeyType>]
    ) async throws -> [Reference]
}

extension ControllerReference {
    public func reference(
        keys: [ID<KeyType>]
    ) async throws -> [Reference] {
        let db = try await components.database().connection()

        return
            try await Query
            .listAll(
                filter: .init(
                    column: Model.keyName,
                    operator: .in,
                    value: keys
                ),
                on: db
            )
            .map {
                try .init(model: $0)
            }
    }
}

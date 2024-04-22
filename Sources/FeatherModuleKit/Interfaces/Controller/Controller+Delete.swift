//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ControllerDelete: KeyedControllerInterface
where Query: DatabaseQueryDelete {
    func bulkDelete(
        ids: [ID<KeyType>]
    ) async throws
}

extension ControllerDelete {
    public func bulkDelete(
        ids: [ID<KeyType>]
    ) async throws {
        let db = try await components.database().connection()
        try await Query.delete(
            filter: .init(
                column: Model.keyName,
                operator: .in,
                value: ids
            ),
            on: db
        )
    }
}

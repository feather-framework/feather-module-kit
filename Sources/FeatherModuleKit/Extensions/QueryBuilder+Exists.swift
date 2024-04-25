//
//  File.swift
//
//
//  Created by Tibor Bodecs on 02/03/2024.
//

import FeatherDatabase

extension DatabaseQueryGet where Row: KeyedDatabaseModel {

    public static func exists(
        _ value: Row.KeyType,
        on db: Database
    ) async throws {
        try await require(value, on: db)
    }
}

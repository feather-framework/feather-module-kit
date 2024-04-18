//
//  File.swift
//
//
//  Created by Tibor Bodecs on 02/03/2024.
//

import FeatherDatabase

extension DatabaseQueryGet where Row: KeyedDatabaseModel {

    public static func require(
        _ value: Row.KeyType,
        on db: Database
    ) async throws -> Row {
        if let ret = try await get(value, on: db) {
            return ret
        }
        throw ModuleError.objectNotFound(
            model: String(reflecting: Row.self),
            keyName: Row.keyName.rawValue
        )
    }
}

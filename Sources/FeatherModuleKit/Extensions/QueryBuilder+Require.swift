//
//  File.swift
//
//
//  Created by Tibor Bodecs on 02/03/2024.
//

import DatabaseQueryKit

extension QueryBuilderPrimaryKeyGet {

    public func require(
        _ value: Encodable
    ) async throws -> Row {
        if let ret = try await get(
            value
        ) {
            return ret
        }
        
        throw ModuleError.objectNotFound(
            type: String(
                reflecting: Row.self
            ),
            id: Self.primaryKey.rawValue
        )
    }
}

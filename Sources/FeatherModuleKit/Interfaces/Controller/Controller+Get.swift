//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ControllerGet: KeyedControllerInterface
where
    Query: DatabaseQueryGet,
    Detail.Model == Model
{
    associatedtype Detail: DetailInterface

    func get(
        _ id: ID<ModelKeyTypeT>
    ) async throws -> Detail?

    static func typeDefinition(getdetail: Detail.Type)
}

extension ControllerGet {
    public static func typeDefinition(getdetail: Detail.Type) {}

    public func get(
        _ id: ID<ModelKeyTypeT>
    ) async throws -> Detail? {
        let db = try await components.database().connection()
        guard let model = try await Query.get(id.toKey(), on: db) else {
            return nil
        }

        return try .init(model: model)
    }

    public func require(
        _ id: ID<ModelKeyTypeT>
    ) async throws -> Detail {
        if let ret = try await get(id) {
            return ret
        }
        throw ModuleError.objectNotFound(
            model: String(reflecting: Model.self),
            keyName: Model.keyName.rawValue
        )
    }

    public func exists(
        _ id: ID<ModelKeyTypeT>
    ) async throws -> Bool {
        try await get(id) != nil
    }
}

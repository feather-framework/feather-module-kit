//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ControllerPatch: KeyedControllerInterface
where
    Query: DatabaseQueryUpdate,
    Query: DatabaseQueryGet,
    Model: PatchAdapter,
    Model.Patch == Patch,
    Patch.Key == ModelKeyTypeT,
    Detail.Model == Model
{
    associatedtype Patch: PatchInterface
    associatedtype Detail: DetailInterface

    func patch(
        _ id: ID<ModelKeyTypeT>,
        _ input: Patch
    ) async throws -> Detail

    static func typeDefinition(patch: Patch.Type)
    static func typeDefinition(patchdetail: Detail.Type)
}

extension ControllerPatch {
    public static func typeDefinition(patch: Patch.Type) {}
    public static func typeDefinition(patchdetail: Detail.Type) {}

    public func patch(
        _ id: ID<ModelKeyTypeT>,
        _ input: Patch
    ) async throws -> Detail {
        let db = try await components.database().connection()

        let oldModel = try await Query.require(
            id.toKey(),
            on: db
        )

        try await input.verify(id, on: db)
        try await input.validate(id, on: db)

        let newModel = try Model.init(patch: input, oldModel: oldModel)
        try await Query.update(id.toKey(), newModel, on: db)
        return try .init(model: newModel)
    }
}

//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol PatchInterface {
    associatedtype Key: Identifiable
    func validate(_ originalKey: ID<Key>, on db: Database) async throws
}

public protocol ModelInterfacePatch: DatabaseModel {
    associatedtype Patch: PatchInterface
    init(patch: Patch, oldModel: Self)
}

public protocol ControllerPatch: KeyedControllerInterface
where
    Query: DatabaseQueryUpdate,
    Query: DatabaseQueryGet,
    Model: ModelInterfacePatch,
    Model.Patch == Patch,
    Patch.Key == KeyType,
    Detail.Model == Model
{
    associatedtype Patch: PatchInterface
    associatedtype Detail: DetailInterface

    func patch(
        _ id: ID<KeyType>,
        _ input: Patch
    ) async throws -> Detail
}

extension ControllerPatch {
    public func patch(
        _ id: ID<KeyType>,
        _ input: Patch
    ) async throws -> Detail {
        let db = try await components.database().connection()

        let oldModel = try await Query.require(
            id.toKey(),
            on: db
        )

        try await input.validate(id, on: db)

        let newModel = Model.init(patch: input, oldModel: oldModel)
        try await Query.update(id.toKey(), newModel, on: db)
        return try .init(model: newModel)
    }
}

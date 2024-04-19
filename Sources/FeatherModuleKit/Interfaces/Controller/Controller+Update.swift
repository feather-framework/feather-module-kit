//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol UpdateInterface {
    associatedtype Key: Identifiable
    func validate(_ originalKey: ID<Key>, on db: Database) async throws
}

public protocol ModelInterfaceUpdate: DatabaseModel {
    associatedtype Update: UpdateInterface
    init(update: Update, oldModel: Self)
}

public protocol ControllerUpdate: KeyedControllerInterface
where
    Query: DatabaseQueryUpdate,
    Query: DatabaseQueryGet,
    Model: ModelInterfaceUpdate,
    Model.Update == Update,
    Update.Key == KeyType,
    Detail.Model == Model
{
    associatedtype Update: UpdateInterface
    associatedtype Detail: DetailInterface

    func update(
        key: ID<KeyType>,
        _ input: Update
    ) async throws -> Detail
}

extension ControllerUpdate {
    public func update(
        key: ID<KeyType>,
        _ input: Update
    ) async throws -> Detail {
        let db = try await components.database().connection()

        let oldModel = try await Query.require(key.toKey(), on: db)

        try await input.validate(key, on: db)

        let newModel = Model.init(update: input, oldModel: oldModel)
        try await Query.update(key.toKey(), newModel, on: db)
        return try .init(model: newModel)
    }
}

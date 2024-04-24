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
    init(update: Update, oldModel: Self) throws
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
        _ id: ID<KeyType>,
        _ input: Update
    ) async throws -> Detail

    static func typeDefinition(update: Update.Type)
    static func typeDefinition(detail: Detail.Type)
}

extension ControllerUpdate {
    public static func typeDefinition(update: Update.Type) {}
    public static func typeDefinition(detail: Detail.Type) {}

    public func update(
        _ id: ID<KeyType>,
        _ input: Update
    ) async throws -> Detail {
        let db = try await components.database().connection()

        let oldModel = try await Query.require(id.toKey(), on: db)

        try await input.validate(id, on: db)

        let newModel = try Model.init(update: input, oldModel: oldModel)
        try await Query.update(id.toKey(), newModel, on: db)
        return try .init(model: newModel)
    }
}

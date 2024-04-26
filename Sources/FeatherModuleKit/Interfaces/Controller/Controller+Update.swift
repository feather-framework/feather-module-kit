//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ControllerUpdate: KeyedControllerInterface
where
    Query: DatabaseQueryUpdate,
    Query: DatabaseQueryGet,
    Model: UpdateAdapter,
    Model.Update == Update,
    Update.Key == ModelKeyTypeT,
    Detail.Model == Model
{
    associatedtype Update: UpdateInterface
    associatedtype Detail: DetailInterface

    func update(
        _ id: ID<ModelKeyTypeT>,
        _ input: Update
    ) async throws -> Detail

    static func typeDefinition(update: Update.Type)
    static func typeDefinition(updatedetail: Detail.Type)
}

extension ControllerUpdate {
    public static func typeDefinition(update: Update.Type) {}
    public static func typeDefinition(updatedetail: Detail.Type) {}

    public func update(
        _ id: ID<ModelKeyTypeT>,
        _ input: Update
    ) async throws -> Detail {
        let db = try await components.database().connection()

        let oldModel = try await Query.require(id.toKey(), on: db)

        try await input.verify(id, on: db)
        try await input.validate(id, on: db)

        let newModel = try Model.init(update: input, oldModel: oldModel)
        try await Query.update(id.toKey(), newModel, on: db)
        return try .init(model: newModel)
    }
}

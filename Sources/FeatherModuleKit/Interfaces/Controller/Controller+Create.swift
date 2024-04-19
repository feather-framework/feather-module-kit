//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol CreateInterface {
    func validate(on db: Database) async throws
}

public protocol ModelInterfaceCreate: DatabaseModel {
    associatedtype Create
    init(create: Create)
}

public protocol ControllerCreate: ControllerInterface
where
    Query: DatabaseQueryInsert,
    Model: ModelInterfaceCreate,
    Model.Create == Create,
    Detail.Model == Model
{
    associatedtype Create: CreateInterface
    associatedtype Detail: DetailInterface

    func create(
        _ input: Create
    ) async throws -> Detail
}

extension ControllerCreate {
    public func create(
        _ input: Create
    ) async throws -> Detail {
        let db = try await components.database().connection()

        try await input.validate(on: db)

        let model = Model.init(create: input)

        try await Query.insert(model, on: db)
        return try .init(model: model)
    }
}

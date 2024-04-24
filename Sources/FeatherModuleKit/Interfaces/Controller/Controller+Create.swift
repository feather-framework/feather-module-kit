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
    associatedtype Create: CreateInterface
    init(create: Create) throws
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

    static func typeDefinition(create: Create.Type)
    static func typeDefinition(detail: Detail.Type)
}

extension ControllerCreate {
    public static func typeDefinition(create: Create.Type) {}
    public static func typeDefinition(detail: Detail.Type) {}

    public func create(
        _ input: Create
    ) async throws -> Detail {
        let db = try await components.database().connection()

        try await input.validate(on: db)

        let model = try Model.init(create: input)

        try await Query.insert(model, on: db)
        return try .init(model: model)
    }
}

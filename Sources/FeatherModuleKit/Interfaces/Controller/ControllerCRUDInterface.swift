//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ControllerModelInterface {
    associatedtype Query: DatabaseQueryInterface
    associatedtype Patch: PatchInterface
    associatedtype Update: UpdateInterface
    associatedtype Create: CreateInterface
    associatedtype Detail: DetailInterface
    associatedtype Reference: ReferenceInterface
    associatedtype List: ListInterface
}

public protocol ControllerCRUDInterface:
    ControllerCreate,
    ControllerDelete,
    ControllerGet,
    ControllerList,
    ControllerPatch,
    ControllerReference,
    ControllerUpdate
{
    associatedtype ControllerModel: ControllerModelInterface
    // does not work in 5.9 swift, from 5.10 the default values are ok
    //  (on the other hand it compiles everywhere so removing not needed)
    associatedtype Query = ControllerModel.Query
    associatedtype Patch = ControllerModel.Patch
    associatedtype Update = ControllerModel.Update
    associatedtype Create = ControllerModel.Create
    associatedtype Detail = ControllerModel.Detail
    associatedtype Reference = ControllerModel.Reference
    associatedtype List = ControllerModel.List
}

extension ControllerCRUDInterface {
    // hack because of 5.9 swift, from 5.10 these are not needed
    public static func typeDefinition(query: ControllerModel.Query.Type) {}
    public static func typeDefinition(patch: ControllerModel.Patch.Type) {}
    public static func typeDefinition(update: ControllerModel.Update.Type) {}
    public static func typeDefinition(create: ControllerModel.Create.Type) {}
    public static func typeDefinition(detail: ControllerModel.Detail.Type) {}
    public static func typeDefinition(reference: ControllerModel.Reference.Type)
    {}
    public static func typeDefinition(list: ControllerModel.List.Type) {}
}

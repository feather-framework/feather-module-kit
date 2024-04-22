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
    associatedtype Query = ControllerModel.Query
    associatedtype Patch = ControllerModel.Patch
    associatedtype Update = ControllerModel.Update
    associatedtype Create = ControllerModel.Create
    associatedtype Detail = ControllerModel.Detail
    associatedtype Reference = ControllerModel.Reference
    associatedtype List = ControllerModel.List
}

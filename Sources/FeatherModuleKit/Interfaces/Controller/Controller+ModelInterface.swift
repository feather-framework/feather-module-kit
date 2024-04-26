//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol ControllerModelInterface {
    associatedtype Query: DatabaseQueryInterface
    associatedtype Patch: PatchInterface
    associatedtype Update: UpdateInterface
    associatedtype Create: CreateInterface
    associatedtype Detail: DetailAdapter
    associatedtype Reference: ReferenceAdapter
    associatedtype List: ListAdapter
}

//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol PatchAdapter: DatabaseModel {
    associatedtype Patch: PatchInterface
    init(patch: Patch, oldModel: Self) throws
}

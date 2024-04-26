//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol CreateAdapter: DatabaseModel {
    associatedtype Create: CreateInterface
    init(create: Create) throws
}

//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol ReferenceAdapter {
    associatedtype Model: DatabaseModel
    init(model: Model) throws
}

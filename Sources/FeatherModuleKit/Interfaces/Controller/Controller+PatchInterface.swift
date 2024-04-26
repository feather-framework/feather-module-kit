//
//  File.swift
//  
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol PatchInterface {
    associatedtype Key: Identifiable
    func verify(_ originalKey: ID<Key>, on db: Database) async throws
    func validate(_ originalKey: ID<Key>, on db: Database) async throws
}

extension PatchInterface {
    public func verify(_ originalKey: ID<Key>, on db: Database) async throws {}
}

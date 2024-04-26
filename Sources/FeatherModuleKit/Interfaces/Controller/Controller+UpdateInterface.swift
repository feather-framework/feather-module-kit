//
//  File.swift
//  
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol UpdateInterface {
    associatedtype Key: Identifiable
    func verify(_ originalKey: ID<Key>, on db: Database) async throws
    func validate(_ originalKey: ID<Key>, on db: Database) async throws
}

extension UpdateInterface {
    public func verify(_ originalKey: ID<Key>, on db: Database) async throws {}
}

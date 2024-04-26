//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol CreateInterface {
    func verify(on db: Database) async throws
    func validate(on db: Database) async throws
}

extension CreateInterface {
    public func verify(on db: Database) async throws {}
}

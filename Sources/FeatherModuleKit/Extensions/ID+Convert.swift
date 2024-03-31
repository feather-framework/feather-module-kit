//
//  File.swift
//
//
//  Created by Tibor Bodecs on 02/03/2024.
//

import DatabaseQueryKit

extension ID where Value.RawIdentifier == String {

    public init(_ key: Key<Value>) {
        self.init(rawValue: key.rawValue)
    }

    public func toKey() -> Key<Value> {
        .init(rawValue)
    }
}

extension Key where T: Identifiable, T.RawIdentifier == String {

    public init(_ id: ID<T>) {
        self.init(rawValue: id.rawValue)
    }

    public func toID() -> ID<T> {
        .init(rawValue: rawValue)
    }
}

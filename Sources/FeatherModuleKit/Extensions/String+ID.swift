//
//  File.swift
//
//
//  Created by Tibor Bodecs on 02/03/2024.
//

extension [String] {

    public func toID<T>() -> [ID<T>] where T.RawIdentifier == String {
        map { .init(rawValue: $0) }
    }
}

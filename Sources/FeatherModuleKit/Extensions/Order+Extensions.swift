//
//  File.swift
//
//
//  Created by Tibor Bodecs on 11/03/2024.
//

import FeatherDatabase

extension Order {

    public var queryDirection: DatabaseDirection {
        switch self {
        case .asc: .asc
        case .desc: .desc
        }
    }
}

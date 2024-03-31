//
//  File.swift
//
//
//  Created by Tibor Bodecs on 11/03/2024.
//

import DatabaseQueryKit

extension Order {

    public var queryDirection: QueryDirection {
        switch self {
        case .asc: .asc
        case .desc: .desc
        }
    }
}

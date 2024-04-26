//
//  File.swift
//
//
//  Created by mzperx on 19/04/2024.
//

import FeatherComponent
import FeatherDatabase

public protocol ControllerInterface {
    associatedtype Query: DatabaseQueryInterface
    typealias Model = Query.Row

    var components: ComponentRegistry { get }

    static func typeDefinition(query: Query.Type)
}

extension ControllerInterface {
    public static func typeDefinition(query: Query.Type) {}
}

public protocol KeyedControllerInterface: ControllerInterface
where
    Model: KeyedDatabaseModel,
    Model.KeyType.T: Identifiable,
    Model.KeyType.T.RawIdentifier == String,
    Key<ModelKeyTypeT> == Model.KeyType
{
    associatedtype ModelKeyTypeT = Model.KeyType.T
}

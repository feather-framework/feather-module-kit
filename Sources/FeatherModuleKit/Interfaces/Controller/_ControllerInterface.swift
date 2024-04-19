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
}

public protocol KeyedControllerInterface: ControllerInterface
where
    Model: KeyedDatabaseModel,
    Model.KeyType.T: Identifiable,
    Model.KeyType.T.RawIdentifier == String,
    Key<KeyType> == Model.KeyType
{
    associatedtype KeyType = Model.KeyType.T
}

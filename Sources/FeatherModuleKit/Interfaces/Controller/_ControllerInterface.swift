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
    Model.KeyType == Key<KeyType>,
    KeyType.RawIdentifier == String
{
    associatedtype KeyType: Identifiable
}

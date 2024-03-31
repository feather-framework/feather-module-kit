//
//  File.swift
//
//
//  Created by Tibor Bodecs on 06/03/2024.
//

public protocol Identified {

    associatedtype T: Identifiable

    var id: ID<T> { get }
}

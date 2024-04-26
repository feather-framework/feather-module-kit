//
//  File.swift
//
//
//  Created by mzperx on 26/04/2024.
//

import FeatherDatabase

public protocol UpdateAdapter: DatabaseModel {
    associatedtype Update: UpdateInterface
    init(update: Update, oldModel: Self) throws
}

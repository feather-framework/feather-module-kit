//
//  File.swift
//
//
//  Created by Tibor Bodecs on 13/03/2024.
//

import FeatherDatabase
import FeatherValidation

extension Rule where T: Equatable & Encodable {

    public static func unique<Q: DatabaseQueryCount>(
        _: Q.Type,
        column: Q.Row.ColumnNames,
        message: String? = nil,
        originalValue: T? = nil,
        on db: Database
    ) -> Self {
        .init(
            message: message ?? "The value should be unique."
        ) { value in
            let count = try await Q.count(
                filter: .init(
                    column: column,
                    operator: .equal,
                    value: value
                ),
                on: db
            )
            if let originalValue {
                if originalValue == value {
                    guard count == 1 else {
                        throw RuleError.invalid
                    }
                }
                else {
                    guard count == 0 else {
                        throw RuleError.invalid
                    }
                }
            }
            else {
                guard count == 0 else {
                    throw RuleError.invalid
                }
            }
        }
    }
}

extension Rule where T: RawRepresentable & Object {

    public static func unique<Q: DatabaseQueryCount>(
        _: Q.Type,
        column: Q.Row.ColumnNames,
        message: String? = nil,
        originalValue: T? = nil,
        on db: Database
    ) -> Self {
        .init(
            message: message ?? "The value should be unique."
        ) { value in
            let count = try await Q.count(
                filter: .init(
                    column: column,
                    operator: .equal,
                    value: value
                ),
                on: db
            )
            if let originalValue {
                if originalValue == value {
                    guard count == 1 else {
                        throw RuleError.invalid
                    }
                }
                else {
                    guard count == 0 else {
                        throw RuleError.invalid
                    }
                }
            }
            else {
                guard count == 0 else {
                    throw RuleError.invalid
                }
            }
        }
    }
}

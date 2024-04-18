import FeatherDatabase
import FeatherValidation

extension Rule where T: Equatable & Encodable {

    public static func validateKey<Q: DatabaseQueryGet>(
        _: Q.Type,
        message: String? = nil,
        on db: Database
    ) -> Self where Q.Row: KeyedDatabaseModel, T == Q.Row.KeyType {
        .init(
            message: message ?? "Primary key is not valid."
        ) { value in
            if try await Q.get(value, on: db) == nil {
                throw RuleError.invalid
            }
        }
    }
}

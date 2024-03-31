import DatabaseQueryKit
import FeatherValidation

extension Rule where T: Equatable & Encodable {

    public static func validateKey<QB: QueryBuilderPrimaryKeyGet>(
        queryBuilder: QB,
        message: String? = nil
    ) -> Self {
        .init(
            message: message ?? "Primary key is not valid."
        ) { value in
            if try await queryBuilder.get(value) == nil {
                throw RuleError.invalid
            }
        }
    }
}

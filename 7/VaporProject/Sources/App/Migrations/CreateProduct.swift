import Fluent

struct CreateProduct: AsyncMigration {
    func prepare(on database: Database) async throws {
        try await database.schema("products")
            .id()
            .field("name", .string, .required)
            .field("description", .string, .required)
            .field("price", .float, .required)
            .field("quantity", .int, .required)
            .create()
    }

    func revert(on database: Database) async throws {
        try await database.schema("products").delete()
    }
}
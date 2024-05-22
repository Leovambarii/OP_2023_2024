import Fluent
import Vapor

struct ProductController: RouteCollection {
    func boot(routes: RoutesBuilder) throws {
        let productsRoutes = routes.grouped("products")

        productsRoutes.get(use: getProducts)
        productsRoutes.post(use: addProduct)
        productsRoutes.group(":productID") { product in
            product.get(use: showProduct)
            product.put(use: editProduct)
            product.delete(use: deleteProduct)
        }
    }
        
    func getProducts(req: Request) async throws -> [Product] {
        try await Product.query(on: req.db).all()
    }

    func addProduct(req: Request) async throws -> Product {
        let product = try req.content.decode(Product.self)
        try await product.save(on: req.db)

        return product
    }

    func showProduct(req: Request) async throws -> Product {
        guard let product = try await findProduct(req: req) else {
            throw Abort(.notFound, reason: "Product not found")
        }

        return product
    }

    func editProduct(req: Request) async throws -> Product {
        guard let product = try await findProduct(req: req) else {
            throw Abort(.notFound, reason: "Product not found")
        }
        let updatedProduct = try req.content.decode(Product.self)
        product.name = updatedProduct.name
        product.description = updatedProduct.description
        product.price = updatedProduct.price
        product.quantity = updatedProduct.quantity
        try await product.save(on: req.db)

        return product
    }

    func deleteProduct(req: Request) async throws -> HTTPStatus {
        guard let product = try await findProduct(req: req) else {
            throw Abort(.notFound, reason: "Product not found")
        }

        try await product.delete(on: req.db)
        return .noContent
    }

    private func findProduct(req: Request) async throws -> Product? {
        guard let productID = req.parameters.get("productID", as: UUID.self) else {
            throw Abort(.badRequest, reason: "Invalid or missing productID")
        }
        return try await Product.find(productID, on: req.db)
    }
}

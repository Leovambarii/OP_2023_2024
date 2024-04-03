package my_spring_project.controller

import my_spring_project.model.Credentials
import my_spring_project.model.Product
import my_spring_project.service.AuthService
//import my_spring_project.service.AuthServiceLazy
import org.springframework.beans.factory.annotation.Autowired
import org.springframework.http.HttpStatus
import org.springframework.http.ResponseEntity
import org.springframework.web.bind.annotation.*

@RestController
class AuthController @Autowired constructor(private val authService: AuthService) { // swap for AuthServiceLazy

    private val products = listOf(
        Product(1, "Product 1", "Description 1", 1, 15),
        Product(2, "Product 2", "Description 2", 2, 25),
        Product(3, "Product 3", "Description 3", 1, 10)
    )

    @GetMapping("/products")
    fun getProducts(): ResponseEntity<Any> {
        return if (authService.isAuthenticated()) {
            ResponseEntity.ok(products)
        } else {
            ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authenticate first!")
        }
    }

    @GetMapping("/products/{productId}")
    fun getProductById(@PathVariable productId: Int): ResponseEntity<Any> {
        if (!authService.isAuthenticated()) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authenticate first!")
        }

        val product = products.getOrNull(productId - 1)
        return if (product != null) {
            ResponseEntity.ok(product)
        } else {
            ResponseEntity.status(HttpStatus.NOT_FOUND).body("Product not found...")
        }
    }

    @PostMapping("/login")
    fun login(@RequestBody credentials: Credentials): ResponseEntity<String> {
        return try {
            if (authService.authenticate(credentials.username, credentials.password)) {
                ResponseEntity.ok("Authentication successful!")
            } else {
                ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Authentication failed...")
            }
        } catch (ex: Exception) {
            ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("An error occurred during authentication...")
        }
    }

    @PostMapping("/logout")
    fun logout(): ResponseEntity<String> {
        authService.logout()
        return ResponseEntity.ok("Logout successful")
    }

}
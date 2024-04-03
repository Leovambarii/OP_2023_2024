package my_spring_project.model

data class Product (
    var id: Int,
    val name: String,
    val description: String,
    var category: Int,
    var price: Int
)
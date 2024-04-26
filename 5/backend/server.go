package main

import (
	"backend/controllers"
	"backend/database"
	"backend/models"
	"github.com/labstack/echo/v4"
	"github.com/labstack/echo/v4/middleware"
	"net/http"
)

func main() {
	e := echo.New()
	e.Use(middleware.CORS())
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})

	DB := database.Init()

	productData := []models.Product{
		{Name: "Table", Description: "Made of wood.", Price: 350.99},
		{Name: "Table Lamp", Description: "Modern product.", Price: 55.99},
		{Name: "Laptop", Description: "Newest technology.", Price: 1250.0},
	}
	err := database.LoadProductData(DB, productData)
	if err != nil {
		panic(err)
	}

	productController := controllers.NewProductController(DB)
	e.GET("/products", productController.GetProducts)

	paymentController := controllers.NewPaymentController(DB)
	e.POST("/payment", paymentController.MakePayment)

	e.Logger.Fatal(e.Start(":8080"))
}

package controllers

import (
	"backend/models"
	"errors"
	"github.com/labstack/echo/v4"
	"gorm.io/gorm"
	"net/http"
)

type ProductController struct {
	DB *gorm.DB
}

func NewProductController(db *gorm.DB) *ProductController {
	return &ProductController{DB: db}
}

func (pc *ProductController) GetProducts(c echo.Context) error {
	var products []models.Product
	if err := pc.DB.Find(&products).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {

			return c.JSON(http.StatusNotFound, map[string]string{"error": "product not found"})
		}

		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "internal server error"})
	}

	return c.JSON(http.StatusOK, products)
}

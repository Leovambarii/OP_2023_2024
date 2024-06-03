package controllers

import (
	"backend/models"
	"fmt"
	"github.com/labstack/echo/v4"
	"gorm.io/gorm"
	"net/http"
	"strconv"
	"time"
)

type PaymentController struct {
	DB *gorm.DB
}

func NewPaymentController(db *gorm.DB) *PaymentController {
	return &PaymentController{DB: db}
}

func (pc *PaymentController) MakePayment(c echo.Context) error {
	var payment models.Payment
	if err := c.Bind(&payment); err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "invalid request body"})
	}

	amount, err := strconv.ParseFloat(payment.Amount.String(), 64)
	if err != nil {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "invalid payment amount"})
	}

	if amount <= 0 {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "invalid payment amount"})
	}

	if payment.CardNumber == "" || payment.ExpiryDate == "" || isExpired(payment.ExpiryDate) {
		return c.JSON(http.StatusBadRequest, map[string]string{"error": "bad card"})
	}

	return c.JSON(http.StatusOK, map[string]string{"message": "payment successful"})
}

func isExpired(dateStr string) bool {
	parsedDate, err := time.Parse("01/06", dateStr)
	if err != nil {
		fmt.Println("Error parsing date:", err)
		return true
	}

	currentDate := time.Now()

	return parsedDate.Before(currentDate)
}

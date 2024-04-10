package controllers

import (
	"errors"
	"fmt"
	"github.com/labstack/echo/v4"
	"gorm.io/gorm"
	"myapp/database"
	"myapp/models"
	"myapp/proxy"
	"net/http"
	"strings"
)

type WeatherController struct {
	DB *gorm.DB
}

func NewWeatherController(db *gorm.DB) *WeatherController {
	return &WeatherController{DB: db}
}

func (wc *WeatherController) GetWeathersDB(c echo.Context) error {
	var weathers []models.Weather
	wc.DB.Find(&weathers)

	return c.JSON(200, weathers)
}

func (wc *WeatherController) GetWeatherDB(c echo.Context) error {
	cities := strings.Split(c.Param("city"), ",")

	var weatherList []models.Weather
	for _, city := range cities {
		var weather models.Weather
		if err := wc.DB.Where("city = ?", city).First(&weather).Error; err != nil {
			if errors.Is(err, gorm.ErrRecordNotFound) {
				return c.JSON(http.StatusNotFound, map[string]string{"error": fmt.Sprintf("Weather data not found for the city: %s", city)})
			}
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to retrieve weather data"})
		}

		weatherList = append(weatherList, weather)
	}

	if len(cities) == 1 {
		return c.JSON(http.StatusOK, weatherList[0])
	}

	return c.JSON(http.StatusOK, weatherList)
}

func (wc *WeatherController) GetWeatherApi(c echo.Context) error {
	apiProxy := proxy.NewProxy()

	weatherResponses, err := apiProxy.GetWeatherApi(c)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": err.Error()})
	}

	for _, weatherResponse := range weatherResponses {
		if err := database.SaveApiData(wc.DB, weatherResponse); err != nil {
			fmt.Println("Error saving or updating weather data:", err)
		}
	}

	if len(weatherResponses) == 1 {
		return c.JSON(http.StatusOK, weatherResponses[0])
	}

	return c.JSON(http.StatusOK, weatherResponses)
}

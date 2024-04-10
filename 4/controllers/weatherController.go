package controllers

import (
	"encoding/json"
	"errors"
	"github.com/labstack/echo/v4"
	"gorm.io/gorm"
	"io"
	"myapp/models"
	"net/http"
	"os"
)

type WeatherController struct {
}

type errorResponse struct {
	Error struct {
		Message string `json:"message"`
	} `json:"error"`
}

func (wc *WeatherController) GetWeathers(c echo.Context) error {
	DB := c.Get("weather").(*gorm.DB)
	var weathers []models.Weather
	DB.Find(&weathers)

	return c.JSON(200, weathers)
}

func (wc *WeatherController) GetWeather(c echo.Context) error {
	city := c.Param("city")
	DB := c.Get("weather").(*gorm.DB)

	var weather models.Weather
	if err := DB.Where("city = ?", city).First(&weather).Error; err != nil {
		if errors.Is(err, gorm.ErrRecordNotFound) {
			return c.JSON(http.StatusNotFound, map[string]string{"error": "Weather data not found for the city"})
		}
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to retrieve weather data"})
	}

	return c.JSON(http.StatusOK, weather)
}

func (wc *WeatherController) GetWeatherApi(c echo.Context) error {
	q := c.Param("city")
	key := os.Getenv("key")
	res, err := http.Get("https://api.weatherapi.com/v1/forecast.json?key=" + key + "&q=" + q + "&aqi=no")
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to fetch weatherResponse data from the external API"})
	}

	body, err := io.ReadAll(res.Body)
	if err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to read response body"})
	}

	if res.StatusCode != http.StatusOK {
		var errorResponse errorResponse
		if err := json.Unmarshal(body, &errorResponse); err != nil {
			return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to parse error response"})
		}
		return c.JSON(http.StatusBadRequest, map[string]string{"error": errorResponse.Error.Message})
	}

	var weatherResponse models.WeatherResponse
	if err := json.Unmarshal(body, &weatherResponse); err != nil {
		return c.JSON(http.StatusInternalServerError, map[string]string{"error": "Failed to parse weatherResponse data"})
	}

	weather := models.ConvertWeatherResponseToWeather(weatherResponse)

	return c.JSON(http.StatusOK, weather)
}

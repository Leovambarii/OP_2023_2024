package main

import (
	"github.com/labstack/echo/v4"
	"myapp/controllers"
	"myapp/database"
	"myapp/models"
	"net/http"
)

func main() {
	e := echo.New()
	e.GET("/", func(c echo.Context) error {
		return c.String(http.StatusOK, "Hello, World!")
	})

	DB := database.Init()
	weatherData := []models.Weather{
		{City: "Warsaw", Country: "Poland", TempC: 22.5, Condition: "Partly cloudy"},
		{City: "Cracow", Country: "Poland", TempC: 25.3, Condition: "Sunny"},
		{City: "Lublin", Country: "Poland", TempC: 27.1, Condition: "Overcast"},
	}
	err := database.LoadData(DB, weatherData)
	if err != nil {
		panic(err)
	}

	e.Use(func(next echo.HandlerFunc) echo.HandlerFunc {
		return func(c echo.Context) error {
			c.Set("weather", DB)
			return next(c)
		}
	})

	weatherController := controllers.WeatherController{}

	e.GET("/weather/db", weatherController.GetWeathers)
	e.GET("/weather/db/:city", weatherController.GetWeather)
	e.GET("/weather/api/:city", weatherController.GetWeatherApi)

	e.Logger.Fatal(e.Start(":8080"))
}

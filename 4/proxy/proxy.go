package proxy

import (
	"encoding/json"
	"fmt"
	"github.com/labstack/echo/v4"
	"io"
	"myapp/models"
	"net/http"
	"os"
	"strings"
)

type errorResponse struct {
	Error struct {
		Message string `json:"message"`
	} `json:"error"`
}

type Proxy struct {
}

func NewProxy() *Proxy {
	return &Proxy{}
}

func (p *Proxy) GetWeatherApi(c echo.Context) ([]models.WeatherResponse, error) {
	cities := strings.Split(c.Param("city"), ",")
	key := os.Getenv("key")

	var weatherResponses []models.WeatherResponse
	for _, city := range cities {
		res, err := http.Get("https://api.weatherapi.com/v1/forecast.json?key=" + key + "&q=" + city + "&aqi=no")
		if err != nil {
			return nil, fmt.Errorf("error while fetching weather data for city %s: %w", city, err)
		}
		defer res.Body.Close()

		body, err := io.ReadAll(res.Body)
		if err != nil {
			return nil, fmt.Errorf("error while reading response body for city %s: %w", city, err)
		}

		if res.StatusCode != http.StatusOK {
			var errorResponse errorResponse
			if err := json.Unmarshal(body, &errorResponse); err != nil {
				return nil, fmt.Errorf("error while unmarshalling error response for city %s: %w", city, err)
			}
			return nil, fmt.Errorf("response status not OK for city %s: %s", city, errorResponse.Error.Message)
		}

		var weatherResponse models.WeatherResponse
		if err := json.Unmarshal(body, &weatherResponse); err != nil {
			return nil, err
		}

		weatherResponses = append(weatherResponses, weatherResponse)
	}

	return weatherResponses, nil
}

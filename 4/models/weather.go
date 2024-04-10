package models

import (
	"gorm.io/gorm"
)

type Weather struct {
	gorm.Model
	City      string  `json:"name"`
	Country   string  `json:"country"`
	TempC     float64 `json:"temp_c"`
	Condition string  `json:"condition"`
}

type WeatherResponse struct {
	Location struct {
		Name    string `json:"name"`
		Country string `json:"country"`
	} `json:"location"`
	Current struct {
		TempC     float64 `json:"temp_c"`
		Condition struct {
			Text string `json:"text"`
		} `json:"condition"`
	} `json:"current"`
}

func ConvertWeatherResponseToWeather(response WeatherResponse) Weather {
	return Weather{
		City:      response.Location.Name,
		Country:   response.Location.Country,
		TempC:     response.Current.TempC,
		Condition: response.Current.Condition.Text,
	}
}

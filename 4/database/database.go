package database

import (
	"errors"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"myapp/models"
)

func Init() *gorm.DB {
	DB, err := gorm.Open(sqlite.Open("weather.db"))
	if err != nil {
		panic("Failed to connect to database")
	}

	err = DB.AutoMigrate(&models.Weather{})
	if err != nil {
		panic("Failed to migrate database")
	}

	return DB
}

func LoadData(db *gorm.DB, weatherData []models.Weather) error {
	for _, weather := range weatherData {
		var existingWeather models.Weather
		res := db.Where("city = ? AND country = ?", weather.City, weather.Country).First(&existingWeather)
		if res.Error != nil && !errors.Is(res.Error, gorm.ErrRecordNotFound) {
			return res.Error
		}

		if errors.Is(res.Error, gorm.ErrRecordNotFound) {
			if err := db.Create(&weather).Error; err != nil {
				return err
			}
		}
	}

	return nil
}

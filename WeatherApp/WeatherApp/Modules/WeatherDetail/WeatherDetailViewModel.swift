//
//  WeatherDetailViewModel.swift
//  WeatherApp
//
//  Created by Temiloluwa on 07-12-2025.
//

import Foundation

class WeatherDetailViewModel {

    private let weatherData: WeatherData
    
    var cityName: String {
        weatherData.name
    }
    
    var temperature: String {
        weatherData.temperatureString
    }
    
    var weatherDescription: String {
        weatherData.weatherDescription
    }
    
    var feelsLikeTemperature: String {
        weatherData.feelsLikeString
    }
    
    var humidity: String {
        weatherData.humidityString
    }
    
    var windspeed: String {
        if let speed = weatherData.wind.speed {
            return String(format: "Wind: %.1f km/h", speed)
        }
        return "Wind: N/A"
    }
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
    }
}

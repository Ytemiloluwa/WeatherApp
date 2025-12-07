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
    
    init(weatherData: WeatherData) {
        self.weatherData = weatherData
    }
}

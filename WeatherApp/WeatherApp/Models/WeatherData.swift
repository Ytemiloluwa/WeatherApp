//
//  WeatherData.swift
//  WeatherApp
//
//  Created by Temiloluwa on 06-12-2025.
//

import Foundation

struct WeatherData: Codable {
    
    let name: String
    let weather: [Weather]
    let main: Main
    let wind: Wind
    
    
    struct Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temp: Double
        let feelsLike: Double?
        let humidity: Int?
        
        enum CodingKeys: String, CodingKey {
            
            case temp
            case feelsLike = "feels_like"
            case humidity
            
        }
    }
    
    struct Wind: Codable {
        let speed: Double?
    }
    
}

/* i used extension below to achieve SRP (Single Responsibility Principle) one of SOLID principle.
 WeatherData struct is only responsible for data while extension is responsible for presentation */
extension WeatherData {
    
    var temperatureString: String {
        String(format: "%.1f°C", main.temp)
    }
    
    var weatherDescription: String {
        weather.first?.description.capitalized ?? "N/A"
    }
    
    var feelsLikeString: String {
        if let feelsLike = main.feelsLike {
            return String(format: "Feels like %.1f°C", feelsLike)
        }
        return "N/A"
    }
    
    var humidityString: String {
        if let humidity = main.humidity {
            return "Humidity: \(humidity)%"
        }
        return "N/A"
    }
}

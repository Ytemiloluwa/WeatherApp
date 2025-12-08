//
//  WeatherServiceTests.swift
//  WeatherAppTest
//
//  Created by Temiloluwa on 08-12-2025.
//

import XCTest

@testable import WeatherApp

class WeatherServiceTests: XCTestCase {
    
    func testWeatherDataDecoding() throws {
        // Given
        let json = """
        {
            "name": "London",
            "weather": [{
                "id": 800,
                "main": "Clear",
                "description": "clear sky",
                "icon": "01d"
            }],
            "main": {
                "temp": 15.5,
                "feels_like": 14.8,
                "humidity": 65
            },
            "wind": {
                "speed": 5.2
            }
        }
        """
        
        // When
        let data = json.data(using: .utf8)!
        let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
        
        // Then
        XCTAssertEqual(weatherData.name, "London")
        XCTAssertEqual(weatherData.weather.first?.description, "clear sky")
        XCTAssertEqual(weatherData.main.temp, 15.5)
        XCTAssertEqual(weatherData.main.feelsLike, 14.8)
        XCTAssertEqual(weatherData.main.humidity, 65)
    }
}

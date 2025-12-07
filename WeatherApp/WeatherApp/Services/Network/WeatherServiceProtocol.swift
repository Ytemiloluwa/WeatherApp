//
//  WeatherServiceProtocol.swift
//  WeatherApp
//
//  Created by Temiloluwa on 07-12-2025.
//

import Foundation
// protocol for weatherservice (SOLID principle: Dependency Inversion Principle)
protocol WeatherServiceProtocol {
    
    func fetchWeatherService(for city: String) async throws -> WeatherData
}

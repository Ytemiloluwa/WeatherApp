//
//  WeatherService.swift
//  WeatherApp
//
//  Created by Temiloluwa on 07-12-2025.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
    
    private let apiKey = Config.apiKey
    
    private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
    
    func fetchWeatherService(for city: String) async throws -> WeatherData {
        
        guard let url = URL(string: "\(baseURL)?q=\(city)&appid=\(apiKey)&units=metric") else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        
        do {
            return try JSONDecoder().decode(WeatherData.self, from: data)
        } catch {
            throw WeatherError.decodingError
        }
    }
    
    enum WeatherError: Error {
        
        case invalidURL
        case invalidResponse
        case decodingError
        case cityNotFound
        
    }
}



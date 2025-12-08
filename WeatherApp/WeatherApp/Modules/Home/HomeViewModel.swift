//
//  HomeViewModel.swift
//  WeatherApp
//
//  Created by Temiloluwa on 07-12-2025.
//

import Foundation

class HomeViewModel {
    
    //callbacks for UI updates
    var didUpdateCityName: ((String) -> Void)?
    var didUpdateLoading: ((Bool) -> Void)?
    var didUpdateError: ((String?) -> Void)?
    
    private let weatherService: WeatherServiceProtocol
    private let cityStorage: CityStorageProtocol
    
    var cityName: String = "" {
        didSet {
            didUpdateCityName?(cityName)
        }
    }
    
    var isLoading: Bool = false {
        didSet {
            didUpdateLoading?(isLoading)
        }
    }
    
    var errorMessage: String? {
        didSet {
            didUpdateError?(errorMessage)
        }
    }
    
    
    init(weatherService: WeatherServiceProtocol, cityStorage: CityStorageProtocol) {
        self.weatherService = weatherService
        self.cityStorage = cityStorage
        loadFavoriteCity()
    }
    
    func loadFavoriteCity() {
        if let favoriteCity = cityStorage.getFavoriteCity() {
            self.cityName = favoriteCity
        }
    }
    
    func saveFavoriteCity() {
        guard !cityName.isEmpty else { return }
        cityStorage.saveFavoriteCity(cityName)
    }
    
    func fetchWeather() async -> WeatherData? {
        
        guard !cityName.isEmpty else {
            
            errorMessage = "Please enter a city name"
            return nil
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            let weatherData = try await weatherService.fetchWeatherService(for: cityName)
            isLoading = false
            return weatherData
        } catch {
            isLoading = false
            errorMessage = "Failed to fetch weather data"
            return nil
        }
    }
    
    func updateCityname(_ name: String) {
        
        cityName = name
    }
}

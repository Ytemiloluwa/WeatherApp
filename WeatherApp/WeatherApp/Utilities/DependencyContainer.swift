//
//  DependencyContainer.swift
//  WeatherApp
//
//  Created by Temiloluwa on 07-12-2025.
//


class DependencyContainer {
    
    static let shared = DependencyContainer()
    
    // MARK: - SERVICES (DI: Depemdency Injection)
    
    private lazy var weatherService: WeatherServiceProtocol = {
        
        return WeatherService()
    }()
    private lazy var cityStorage: CityStorageProtocol = {
        return CityStorage()
    }()
    
    // SOLID PRINCIPLE (Open/closed principle): i leveraged the factory design pattern to achieve loose coupling.
    
    func makeHomeViewModel() -> HomeViewModel {
        
        return HomeViewModel(weatherService: weatherService, cityStorage: cityStorage)
        
    }
    
    func makeWeatherDetailViewModel(weatherData: WeatherData) -> WeatherDetailViewModel {
        
        return WeatherDetailViewModel(weatherData: weatherData)
    }
}

//
//  HomeViewModelTests.swift
//  WeatherAppTest
//
//  Created by Temiloluwa on 07-12-2025.
//

import XCTest
@testable import WeatherApp

class HomeViewModelTests: XCTestCase {
    
    public var viewModel: HomeViewModel!
    var mockWeatherService: MockWeatherService!
    var mockCityStorage: MockCityStorage!
    
    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
        mockCityStorage = MockCityStorage()
        viewModel = HomeViewModel(
            weatherService: mockWeatherService,
            cityStorage: mockCityStorage
        )
    }
    
    override func tearDown() {
        viewModel = nil
        mockWeatherService = nil
        mockCityStorage = nil
        super.tearDown()
    }
    
    func testSaveFavoriteCity() {
        // Given
        viewModel.updateCityname("Lagos")
        
        // When
        viewModel.saveFavoriteCity()
        
        // Then
        XCTAssertTrue(mockCityStorage.saveWasCalled)
        XCTAssertEqual(mockCityStorage.savedCity, "Lagos")
    }
    
    func testLoadFavoriteCity() {
        // Given
        mockCityStorage.mockFavoriteCity = "Paris"
        viewModel.updateCityname("")
        
        // When
        viewModel.loadFavoriteCity()
        
        // Then
        XCTAssertEqual(viewModel.cityName, "Paris")
    }
    
    func testFetchWeatherSuccess() async {
        // Given
        await viewModel.updateCityname("Lagos")
        mockWeatherService.mockWeatherData = WeatherData(
            name: "London",
            weather: [WeatherData.Weather(id: 800, main: "Clear", description: "clear sky", icon: "01d")],
            main: WeatherData.Main(temp: 15.0, feelsLike: 14.0, humidity: 65),
            wind: WeatherData.Wind(speed: 5.0)
        )
        
        // When
        let weatherData = await viewModel.fetchWeather()
        
        // Then
        XCTAssertNotNil(weatherData)
        XCTAssertEqual(weatherData?.name, "London")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }
    
    func testFetchWeatherEmptyCity() async {
        // Given
        await viewModel.updateCityname("")
        
        // When
        let weatherData = await viewModel.fetchWeather()
        
        // Then
        XCTAssertNil(weatherData)
        XCTAssertEqual(viewModel.errorMessage, "Please enter a city name")
    }
}

// MARK: - Mock Classes (Dependency Injection for Testing)
class MockWeatherService: WeatherServiceProtocol {
    var mockWeatherData: WeatherData?
    var mockError: Error?
    var fetchWasCalled = false
    var lastCityRequested: String?
    
    func fetchWeatherService(for city: String) async throws -> WeatherData {
        fetchWasCalled = true
        lastCityRequested = city
        
        if let error = mockError {
            throw error
        }
        
        if let data = mockWeatherData {
            return data
        }
        
        throw WeatherService.WeatherError.cityNotFound
    }
}

class MockCityStorage: CityStorageProtocol {
    var mockFavoriteCity: String?
    var saveWasCalled = false
    var savedCity: String?
    
    func saveFavoriteCity(_ city: String) {
        saveWasCalled = true
        savedCity = city
    }
    
    func getFavoriteCity() -> String? {
        return mockFavoriteCity
    }
}

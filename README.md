# WeatherApp Take Home

## Features
- MVVM Architecture
- Storyboard UI
- Dependency Injection
- Unit Tests
- SOLID Principles
- OpenWeather API Integration
- Supports dark/light mode

## Requirements
- iOS 15.0+
- Xcode 26+
- OpenWeather API Key

## Installation
1. Clone repository
2. Open `WeatherApp.xcodeproj`
3. Get API key from [OpenWeather](https://openweathermap.org/api)
4. Create a config file to store your API_KEY which is used  `WeatherService.swift`
5. Build and run

## Project Structure

```
WeatherApp/
├── App/
│   ├── AppDelegate.swift          
│   └── SceneDelegate.swift       
│
├── Modules/                 
│   ├── Home/
│   │   ├── HomeViewController.swift   
│   │   └── HomeViewModel.swift         
│   └── WeatherDetail/
│       ├── WeatherDetailViewController.swift  
│       └── WeatherDetailViewModel.swift       
│
├── Models/                       
│   └── WeatherData.swift      
│
├── Services/                      
│   ├── Network/
│   │   ├── WeatherServiceProtocol.swift 
│   │   └── WeatherService.swift       
│   └── Storage/
│       ├── CityStorageProtocol.swift   
│       └── CityStorage.swift       
│
├── Utilities/                   
│   ├── Config.swift              
│   └── DependencyContainer.swift
│
├── Storyboards/             
│   ├── Base.lproj/
│   │   └── LaunchScreen.storyboard
│   └── Main.storyboard         
│
└── Assets.xcassets/           

WeatherAppTest/              
├── ViewModels/
│   └── HomeViewModelTests.swift  
├── Service/
│   └── WeatherServiceTests.swift 
└── Mocks/             
```

### Architecture Overview

- **MVVM Pattern**: Clear separation between View (ViewControllers), ViewModel (business logic), and Model (data)
- **Dependency Injection**: `DependencyContainer` manages service dependencies
- **Protocol-Oriented**: Services use protocols for testability and flexibility
- **SOLID Principles**: Single Responsibility, Dependency Inversion, and Open/Closed principles applied

## SOLID Principles Demonstrated

### ✅ Single Responsibility

- **WeatherService**: Only fetches weather data
- **CityStorage**: Only handles storage operations
- **ViewModels**: Only business logic
- **ViewControllers**: Only UI updates

### ✅ Open/Closed

- Protocols allow extending without modifying existing code
- Can add new weather sources without changing ViewModels

### ✅ Liskov Substitution

- Mock services can substitute real ones in tests
- Any `WeatherServiceProtocol` implementation works

### ✅ Interface Segregation

- Separate protocols for `WeatherService` and `CityStorage`
- ViewModels depend only on what they need

### ✅ Dependency Inversion

- ViewModels depend on abstractions (protocols), not concretions
- `DependencyContainer` manages all dependencies

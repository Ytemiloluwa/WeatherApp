# WeatherApp Take Home

## Dark Mode
<div align="center" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; max-width: 600px; margin: 0 auto">
  <img src="https://github.com/user-attachments/assets/7e1430f4-b9a6-4d93-a102-95e41aea68ae" width="280" />
  <img src="https://github.com/user-attachments/assets/1c610871-94ce-4cfb-b7a7-33805cd7942f" width="280" />
</div>

## Light Mode
<div align="center" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 20px; max-width: 600px; margin: 0 auto">
  <img src="https://github.com/user-attachments/assets/cdce4227-56b7-4879-aec1-ef73169d199a" width="280" />
  <img src="https://github.com/user-attachments/assets/08933c44-179e-4855-a3b7-74af76ebc3a6" width="280" />
</div>

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

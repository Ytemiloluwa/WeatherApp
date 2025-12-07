//
//  CityStorage.swift
//  WeatherApp
//
//  Created by Temiloluwa on 07-12-2025.
//

import Foundation

class CityStorage: CityStorageProtocol {
    
    func saveFavoriteCity(_ city: String) {
        
        UserDefaults.standard.set(city, forKey: "favoriteCity")
    }
    
    func getFavoriteCity() -> String? {
        UserDefaults.standard.string(forKey: "favoriteCity")
    }
    
}

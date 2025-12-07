//
//  CityStorageProtocol.swift
//  WeatherApp
//
//  Created by Temiloluwa on 07-12-2025.
//

import Foundation

protocol CityStorageProtocol {
    
    func saveFavoriteCity(_ city: String)
    func getFavoriteCity() -> String?
}

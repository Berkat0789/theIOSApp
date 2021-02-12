//
//  ForecastData.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import Foundation



struct ForecastData: Decodable {
    let city: CityDetails
    let list: [weatherData]
    
}

struct CityDetails: Decodable {
    let name: String
}

struct weatherData: Decodable {
    let weather: [WeatherDetails]
    let main: Tempp
    
}

struct Tempp: Decodable {
    let temp: Double
}
struct WeatherDetails: Decodable {
    let description: String
    let id: Int
}


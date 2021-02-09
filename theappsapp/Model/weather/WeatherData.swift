//
//  WeatherData.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import Foundation




struct WeatherData: Decodable {
    let name: String
    let main: Temperature
    let weather:[Details]
    
}

struct Temperature: Decodable {
    let temp: Double
}
struct Details: Decodable {
    let description:String
    let id: Int
}

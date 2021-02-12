//
//  Weather.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import Foundation



struct Weather {
    let cityName: String
    let condition: String
    let temp :Double
    let id :Int
    
    
    var tempString: String {
        return String(format: "%.1f", temp)
    }
}

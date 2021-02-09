//
//  ForecastService.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import Foundation
import CoreLocation


private let apiKey = "94575f2b659527a9f2e2d58b8a2c7044"


// This could actually be handled in the weather service with a different decoder call
// For now we will leave its its own file

protocol forecastDelegate {
    func didFinishGettingForecastData(forecast: [Weather])
}

struct ForecastService {
    
    var delegate: forecastDelegate?
    
    func getForecastDataFor(cityname: String) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?q=\(cityname)&appid=\(apiKey)&units=imperial"
        print(url)
        fetchForecastData(url: url)
    }
    //func get forcast data for coordinates
    func getForecastDataFor(coordinates: CLLocationCoordinate2D) {
        let url = "https://api.openweathermap.org/data/2.5/forecast?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(apiKey)&units=imperial"
        fetchForecastData(url: url)
    }
    
    
    func fetchForecastData(url: String) {
        guard let url = URL(string: url) else {return}
        let session = URLSession(configuration: URLSessionConfiguration.default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print("There was an error getting data for url \(err)")
            } else {
                //There was no error
                guard let dd = data else{fatalError("No data returned from task")}
                let Forecast = self.decodeFOrecast(data: dd)
                self.delegate?.didFinishGettingForecastData(forecast: Forecast)
            }
        }
        task.resume()
    }
    private func decodeFOrecast(data: Data) -> [Weather] {
        var forecastList = [Weather]()
        let decoder = JSONDecoder()
        do {
            let forcast = try decoder.decode(ForecastData.self, from: data)
            forcast.list.forEach { (weatherObj) in
                let weather_detail = Weather(cityName: forcast.city.name, condition: weatherObj.weather[0].description, temp: weatherObj.main.temp, id: weatherObj.weather[0].id)
                forecastList.append(weather_detail)
            }
            return forecastList
        } catch {
            print("thee was an error decoding \(error.localizedDescription)")
            forecastList = []
            return forecastList
        }
    }
}

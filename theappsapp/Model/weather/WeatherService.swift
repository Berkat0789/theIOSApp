//
//  WeatherService.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import Foundation
import CoreLocation


// protocol to pass wether data

protocol weatherDelegate {
    func didFinishGetting(WeatherData: Weather)
}


private let apikey = "94575f2b659527a9f2e2d58b8a2c7044"


struct WeatherService {
    
    var delegate: weatherDelegate?

    // Getting the weather for city name
    
    func fetchWeatherDataForCity(name: String) {
        let url = "https://api.openweathermap.org/data/2.5/weather?q=\(name)&appid=\(apikey)&units=imperial"
        //print(url)
        downloadWeatherFor(url: url)
    }
    //Getting the weathe for the user locaiton
    func getWeatherForUser(coordinates: CLLocationCoordinate2D) {
        let url = "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(apikey)&units=imperial"
       // print(url)
        downloadWeatherFor(url: url)
    }
    
    func downloadWeatherFor(url :String) {        guard let url = URL(string: url) else {fatalError("There is an error processing url")}
        // we beed a rel request to the api using a url session
        let session = URLSession(configuration: URLSessionConfiguration.default)
        // Setting up task
        let task = session.dataTask(with: url) { (data, response, error) in
            //checking for errors
            if let err = error {
                print("there has been an error \(err)")
            }else {
                //There was no error
                guard let responseData = data else {return}
                //let dataString = String(data: responseData, encoding: String.Encoding.utf8)
                //print(dataString)
                guard let weatherObject = decode(data: responseData) else {return}
                self.delegate?.didFinishGetting(WeatherData: weatherObject)
            }
        }
        task.resume()
    }
    private func decode(data: Data) -> Weather? {
        let decoder  = JSONDecoder()
        do {
            let weather = try decoder.decode(WeatherData.self, from: data)
            let returnedWeather = Weather(cityName: weather.name, condition: weather.weather[0].description, temp: weather.main.temp, id: weather.weather[0].id)
            return returnedWeather
        } catch {
            print("There was an error getting weatherData \(error.localizedDescription)")
            return nil
        }
    }
}

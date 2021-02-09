//
//  weatherVC.swift
//  theappsapp
//
//  Created by Berkat Bhatti on 2/8/21.
//

import UIKit
import CoreLocation

class weatherVC: UIViewController {
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var searchField: UITextField!
    @IBOutlet weak var forecastTableView: UITableView!
    
    
    var service = WeatherService()
    var forecastSev = ForecastService()
    var manager = CLLocationManager()
    var forecastWeather = [Weather]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        service.delegate = self
        forecastSev.delegate = self
        manager.delegate = self
        forecastTableView.register(UINib(nibName: K.cellIdentifiers.weatherCell, bundle: nil), forCellReuseIdentifier: K.cellIdentifiers.weatherCell)
        manager.requestWhenInUseAuthorization()
        manager.requestLocation()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func locationPressed(_ sender: Any) {
        manager.requestLocation()
        guard let coord = manager.location?.coordinate else {return}
        service.getWeatherForUser(coordinates: coord)
        forecastSev.getForecastDataFor(coordinates: coord)
    }
    
}



extension weatherVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        forecastWeather.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let weather = forecastWeather[indexPath.row]
        guard let weatherCell = forecastTableView.dequeueReusableCell(withIdentifier: K.cellIdentifiers.weatherCell, for: indexPath) as? weatherCell else {return UITableViewCell()}
        weatherCell.updateCell(weather: weather)
        return weatherCell
    }
    
}

extension weatherVC: forecastDelegate {
    func didFinishGettingForecastData(forecast: [Weather]) {
        DispatchQueue.main.async {
            print(forecast[0].cityName)
            self.forecastWeather = forecast
            self.forecastTableView.reloadData()
        }
    }
}









extension weatherVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let cityName  = searchField.text else{return false}
        service.fetchWeatherDataForCity(name: cityName)
        forecastSev.getForecastDataFor(cityname: cityName)
        searchField.text = ""
        return true
    }
}

extension weatherVC: weatherDelegate {
    func didFinishGetting(WeatherData: Weather) {
        DispatchQueue.main.async {
            self.cityNameLabel.text = WeatherData.cityName
            self.condition.text = WeatherData.condition
            self.tempLabel.text = WeatherData.tempString
        }
    }
}
extension weatherVC: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {fatalError("error fining users locaiton")}
        service.getWeatherForUser(coordinates: location.coordinate)
        forecastSev.getForecastDataFor(coordinates: location.coordinate)
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("There was an error updating user location")
    }
}

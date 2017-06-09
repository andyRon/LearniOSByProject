//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by Simon Ng on 27/10/2016.
//  Copyright © 2016 AppCoda. All rights reserved.
//

import Foundation

class WeatherService {
    typealias WeatherDataCompletionBlock = (_ data: WeatherData?) -> ()
    
    let openWeatherBaseAPI = "http://api.openweathermap.org/data/2.5/weather?appid=5dbb5c068718ea452732e5681ceaa0c7&units=metric&q="
    let urlSession = URLSession.shared
    
    class func sharedWeatherService() -> WeatherService {
        return _sharedWeatherService
    }
    
    func getCurrentWeather(location:String, completion: @escaping WeatherDataCompletionBlock) {
        
        let openWeatherAPI = openWeatherBaseAPI + location.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!

        print(openWeatherAPI)
        
        guard let queryURL = URL(string: openWeatherAPI) else {
            return
        }
        let request = URLRequest(url: queryURL)
        var weatherData = WeatherData()
        
        let task = urlSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
            
            guard let data = data else {
                if let error = error {
                    print(error)
                }
                
                return
            }
            
            // Retrieve JSON data
            do {
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? NSDictionary
                
                // Parse JSON data
                let jsonWeather = jsonResult?["weather"] as! [AnyObject]
                
                for jsonCurrentWeather in jsonWeather {
                    weatherData.weather = jsonCurrentWeather["description"] as! String
                }
                
                let jsonMain = jsonResult?["main"] as! Dictionary<String, AnyObject>
                weatherData.temperature = jsonMain["temp"] as! Int
                
                completion(weatherData)
                
            } catch {
                print(error)
            }
        })
        
        task.resume()
    }
    
}

let _sharedWeatherService: WeatherService = { WeatherService() }()

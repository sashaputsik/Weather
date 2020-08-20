import Foundation
import UIKit

var citiesWeather = [Weather]()

class Parse{
    let url = "http://api.weatherstack.com/current?access_key=80277e0892055782837a53be6b52070d&query="
    func setWeather(of city: String, complitionHandler:((Weather) -> ())?){
          guard let urlString = URL(string: url+(city.replacingOccurrences(of: " ", with: "%20"))) else{return}
          let urlSession = URLSession.shared
          urlSession.dataTask(with: urlString) { [weak self] (data, response, error) in
              guard let data = data else{return}
              guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else{return}
              if  let location = json["location"] as? [String: AnyObject],
                let current = json["current"] as? [String: AnyObject]{
                let cityWeather = Weather(dictLocation: location, dictCurrent: current)
                complitionHandler?(cityWeather)
            }
             
          }.resume()
      }
    func setFavCitiesTemperature(of city: String,complitionHandler:((Int)->())?){
        guard let urlString = URL(string: url+(city.replacingOccurrences(of: " ", with: "%20"))) else{return}
        let session = URLSession.shared
        session.dataTask(with: urlString) { (data, response, error) in
        guard let data = data else{return}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else{return}
        if let current = json["current"]{
            guard let temp = current["temperature"] as? Int else{return}
            complitionHandler?(temp)
        }
        }.resume()
    }
      
}

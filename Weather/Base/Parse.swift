import Foundation
import UIKit

class Parse{
//MARK: Parse all weather description
    let url = "http://api.weatherstack.com/current?access_key=45397ed3c9a204f46327affe2533eb44&query="
    func setWeather(of city: String, complitionHandler:((Weather) -> ())?){
          guard let urlString = URL(string: url+(city.replacingOccurrences(of: " ",
                                                                           with: "%20"))) else{return}
          let urlSession = URLSession.shared
          urlSession.dataTask(with: urlString) { (data, response, error) in
              guard let data = data else{return}
              guard let json = try? JSONSerialization.jsonObject(with: data,
                                                                 options: []) as? [String:AnyObject] else{return}
            if  let location = json[ParseKeys.location.rawValue] as? [String: AnyObject],
                let current = json[ParseKeys.current.rawValue] as? [String: AnyObject]{
                let cityWeather = Weather(dictLocation: location, dictCurrent: current)
                complitionHandler?(cityWeather)
            }
             
          }.resume()
      }
    
//MARK: Parse temperature
    func setFavCitiesTemperature(of city: String,complitionHandler:((Int)->())?){
        guard let urlString = URL(string: url+(city.replacingOccurrences(of: " ", with: "%20"))) else{return}
        let session = URLSession.shared
        session.dataTask(with: urlString) { (data, response, error) in
        guard let data = data else{return}
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else{return}
            if let current = json[ParseKeys.current.rawValue]{
            guard let temp = current[ParseKeys.temperature.rawValue] as? Int else{return}
            complitionHandler?(temp)
        }
        }.resume()
    }
    
//MARK: Set fav cities to array
    func setFavCities(){
        guard let favCitiesArray = UserDefaults.standard.array(forKey: "favCities") as? [String] else{return}
        favCities = favCitiesArray
    }
      
}

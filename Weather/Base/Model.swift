import Foundation

struct Weather{
    var feelsLike: Int
    var description: [String]
    var cloudCover: Int
    var humidity: Int
    var windSpeed: Int
    var visibility: Int
    var cityName: String
    var country: String
    var temperature: Int
    init(dictLocation: [String: AnyObject], dictCurrent: [String: AnyObject]) {
        self.cityName = dictLocation["name"] as? String ?? ""
        self.country = dictLocation["country"] as? String ?? ""
        self.feelsLike = dictCurrent["feelslike"] as? Int ?? 0
        self.description = dictCurrent["weather_descriptions"] as? [String] ?? []
        self.cloudCover = dictCurrent["cloudcover"] as? Int ?? 0
        self.humidity = dictCurrent["humidity"] as? Int ?? 0
        self.windSpeed = dictCurrent["wind_speed"] as? Int ?? 0
        self.visibility = dictCurrent["visibility"] as? Int ?? 0
        self.temperature = dictCurrent["temperature"] as? Int ?? 0
    }
}

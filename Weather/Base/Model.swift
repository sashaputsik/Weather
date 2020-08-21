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
        self.cityName = dictLocation[ParseKeys.cityName.rawValue] as? String ?? ""
        self.country = dictLocation[ParseKeys.country.rawValue] as? String ?? ""
        self.feelsLike = dictCurrent[ParseKeys.feelsLike.rawValue] as? Int ?? 0
        self.description = dictCurrent[ParseKeys.description.rawValue] as? [String] ?? []
        self.cloudCover = dictCurrent[ParseKeys.cloudCover.rawValue] as? Int ?? 0
        self.humidity = dictCurrent[ParseKeys.humidity.rawValue] as? Int ?? 0
        self.windSpeed = dictCurrent[ParseKeys.windSpeed.rawValue] as? Int ?? 0
        self.visibility = dictCurrent[ParseKeys.visibility.rawValue] as? Int ?? 0
        self.temperature = dictCurrent[ParseKeys.temperature.rawValue] as? Int ?? 0
    }
}

//MARK: Parse Enum
enum ParseKeys: String{
    case cityName = "name"
    case country = "country"
    case feelsLike = "feelslike"
    case description = "weather_ description"
    case cloudCover = "cloudcover"
    case humidity = "humidity"
    case windSpeed = "wind_speed"
    case visibility = "visibility"
    case temperature = "temperature"
    case location = "location"
    case current = "current"
}

import UIKit

class ViewController: UIViewController {
    let url = "http://api.weatherstack.com/current?access_key=31053ca50753efd7c09bf127addb619b&query="
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var currentDateLabel: UILabel!
    @IBOutlet weak var feelLikesLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var visibilityLabel: UILabel!
    @IBOutlet weak var cloudCoverLabel: UILabel!
    @IBOutlet weak var descriptionImageView: UIImageView!
    var temp:Int?
    var city:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        //search(of: "moscow")
       // setCurrentDate()
        frameAndLayer()
    }
    @IBAction func segueFavCitiesView(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FavCities") as? FavCitiesTableViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }
    
    func search(of city: String){
        guard let urlString = URL(string: url+(city.replacingOccurrences(of: " ", with: "%20"))) else{return}
        let urlSession = URLSession.shared
        print(urlString)
        urlSession.dataTask(with: urlString) { [weak self] (data, response, error) in
            guard let self = self else{return}
            guard let data = data else{return}
            if error != nil{
                guard let error = error else{return}
                let alertController = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .actionSheet)
                let okeyAction = UIAlertAction(title: "Okey", style: .default, handler: nil)
                alertController.addAction(okeyAction)
                self.present(alertController, animated: true, completion: nil)
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:AnyObject] else{return}
            if  let location = json["location"] as? [String: AnyObject]{
                DispatchQueue.main.async {
                    self.cityLabel.text = location["name"] as? String
                    self.countryLabel.text = location["country"] as? String
                }
                print(location["name"]!)
            }
            if let current = json["current"] as? [String: AnyObject]{
                self.temp = current["temperature"] as? Int
                guard let feelsLike = current["feelslike"] as? Int else{return}
                guard let description = current["weather_descriptions"] as? [String] else{return}
                guard let weatherIcon = current["weather_icons"] as? [String] else{return}
                guard let cloudCover = current["cloudcover"] as? Int else{return}
                guard let humidity = current["humidity"] as? Int else{return}
                guard let windSpeed = current["wind_speed"] as? Int else{return}
                guard let visibility = current["visibility"] as? Int else{return}
                DispatchQueue.main.async {
                    if let temp = self.temp{
                        self.temperatureLabel.text = "\(temp)°"
                    }
                    guard let url = weatherIcon.first else{return}
                    if let imageUrl = URL(string: url){
                        guard let data = try? Data(contentsOf: imageUrl) else{return}
                        self.descriptionImageView.image = UIImage(data: data)
                    }
                    self.feelLikesLabel.text = "Feels like: \(feelsLike) °C"
                    self.cloudCoverLabel.text = "Cloud cover: \(cloudCover)"
                    self.descriptionLabel.text = description.first
                    self.humidityLabel.text = "Humidity: \(humidity) °C"
                    self.windLabel.text = "Wind speed: \(windSpeed)" + " Km/H"
                    self.visibilityLabel.text = "Visibility: \(visibility)"
                }
            }
            self.setCurrentDate()
          
        }.resume()
    }
    func setCurrentDate(){
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d"
        DispatchQueue.main.async {
            self.currentDateLabel.text = dateFormatter.string(from: date)
        }
    }
    func frameAndLayer(){
        descriptionImageView.layer.cornerRadius = descriptionImageView.frame.height/2
    }
}

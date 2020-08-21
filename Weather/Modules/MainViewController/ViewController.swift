import UIKit

class ViewController: UIViewController {
    
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
    override func viewDidLoad() {
        super.viewDidLoad()
        frameAndLayer()
        print(citiesWeather)
        Parse().setWeather(of: "Brest" ) { (cityWeather) in
            print(cityWeather)
            DispatchQueue.main.async {
                self.cityLabel.text = cityWeather.cityName
                self.countryLabel.text = cityWeather.country
                self.temperatureLabel.text = "\(cityWeather.temperature) °C"
                self.feelLikesLabel.text = "\(cityWeather.feelsLike) °C"
                self.cloudCoverLabel.text = "\(cityWeather.cloudCover)"
                self.descriptionLabel.text = cityWeather.description.first?.uppercased()
                self.humidityLabel.text = "\(cityWeather.humidity) °C"
                self.windLabel.text = "\(cityWeather.windSpeed)" + " Km/H"
                self.visibilityLabel.text = "\(cityWeather.visibility)"
                self.setCurrentDate()
            }
        }
    }
    @IBAction func segueFavCitiesView(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "FavCities") as? FavCitiesTableViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }
    
}
extension ViewController{
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
        temperatureLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        temperatureLabel.layer.shadowOpacity = 0.3
        cityLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        cityLabel.layer.shadowOpacity = 0.2
        descriptionLabel.layer.shadowOpacity = 0.3
        descriptionLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
    }
}

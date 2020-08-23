import UIKit

class ViewController: UIViewController {
    
    @IBOutlet private(set) var cityLabel: UILabel!
    @IBOutlet private(set) var countryLabel: UILabel!
    @IBOutlet private(set) var temperatureLabel: UILabel!
    @IBOutlet private(set) var descriptionLabel: UILabel!
    @IBOutlet private(set) var currentDateLabel: UILabel!
    @IBOutlet private(set) var feelLikesLabel: UILabel!
    @IBOutlet private(set) var humidityLabel: UILabel!
    @IBOutlet private(set) var windLabel: UILabel!
    @IBOutlet private(set) var visibilityLabel: UILabel!
    @IBOutlet private(set) var cloudCoverLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        frameAndLayer()
        print(favCities)
        guard let favCity = favCities.first else{return}
        Parse().setWeather(of: favCity ) { (cityWeather) in
            print(cityWeather)
            DispatchQueue.main.async {
                self.cityLabel.text = cityWeather.cityName
                self.countryLabel.text = cityWeather.country
                self.temperatureLabel.text = "\(cityWeather.temperature)" + Values.degrees.rawValue
                self.feelLikesLabel.text = "\(cityWeather.feelsLike)" + Values.degreesC.rawValue
                self.cloudCoverLabel.text = "\(cityWeather.cloudCover)"
                self.descriptionLabel.text = cityWeather.description.first?.uppercased()
                self.humidityLabel.text = "\(cityWeather.humidity)" + Values.degreesC.rawValue
                self.windLabel.text = "\(cityWeather.windSpeed)" + Values.kmPerH.rawValue
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
        currentDateLabel.text = dateFormatter.string(from: date)
    }
    
    func frameAndLayer(){
        temperatureLabel.layer.shadowOffset = Appearence().shadowOffset
        temperatureLabel.layer.shadowOpacity = Appearence().shadowOpacity
        cityLabel.layer.shadowOffset = Appearence().shadowOffset
        cityLabel.layer.shadowOpacity = Appearence().shadowOpacity
        descriptionLabel.layer.shadowOffset = Appearence().shadowOffset
        descriptionLabel.layer.shadowOpacity = Appearence().shadowOpacity
    }
}

private extension ViewController{
    struct Appearence {
        let shadowOffset = CGSize(width: 1, height: 1)
        let shadowOpacity: Float = 0.3
    }
}

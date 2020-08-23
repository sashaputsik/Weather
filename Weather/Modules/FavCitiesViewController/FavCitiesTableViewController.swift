import UIKit

class FavCitiesTableViewController: UITableViewController {
    @IBOutlet private(set) var footer: UIView!
    private let refresher = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher.addTarget(self,
                            action: #selector(valueUpdate),
                            for: .valueChanged)
        tableView.addSubview(refresher)
        }
    override func viewWillAppear(_ animated: Bool) {
        guard let userDefaultFavCities = UserDefaults.standard.value(forKey: "favCities") as? [String] else{return}
        favCities = userDefaultFavCities
    }
    @objc private func valueUpdate(){
        tableView.reloadData()
        refresher.endRefreshing()
    }
    @IBAction func addedFavCities(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SelectYouCity") as? SelectYouCityViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }

    override func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        return favCities.count
    }
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.id,
                                                       for: indexPath) as? FavCitiesTableViewCell else{return UITableViewCell()}
        cell.nameOfCityLabel.text = favCities[indexPath.row]
        Parse().setFavCitiesTemperature(of: favCities[indexPath.row]) { (temperature) in
            DispatchQueue.main.async {
                cell.temperatureLabel.text = "\(temperature)" + Values.degrees.rawValue
                tableView.reloadData()
            }
        }
            return cell
    }
        
    override func tableView(_ tableView: UITableView,
                            didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
        Parse().setWeather(of: favCities[indexPath.row]) { (cityWeather) in
            print(cityWeather)
            DispatchQueue.main.async {
                vc.cityLabel.text = cityWeather.cityName
                vc.countryLabel.text = cityWeather.country
                vc.temperatureLabel.text = "\(cityWeather.temperature)°"
                vc.feelLikesLabel.text = "\(cityWeather.feelsLike)" + Values.degreesC.rawValue
                vc.cloudCoverLabel.text = "\(cityWeather.cloudCover)"
                vc.descriptionLabel.text = cityWeather.description.first?.uppercased()
                vc.humidityLabel.text = "\(cityWeather.humidity)" + Values.degreesC.rawValue
                vc.windLabel.text = "\(cityWeather.windSpeed)" + Values.kmPerH.rawValue
                vc.visibilityLabel.text = "\(cityWeather.visibility)"
                vc.setCurrentDate()
            }
        }
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            favCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath],
                                 with: .left)
            UserDefaults.standard.set(favCities,
                                      forKey: "favCities")
            UserDefaults.standard.synchronize()
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    
}

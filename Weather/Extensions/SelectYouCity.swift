import Foundation
import UIKit

//MARK: UITableViewDelegateDataSource
extension SelectYouCityViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return searchingCities.count
        }
        else{
            return Cities().city_names.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.textColor = .white
        cell.textLabel?.font = .systemFont(ofSize: 15)
        if isSearching{
            cell.textLabel?.text = searchingCities[indexPath.row]
        }
        else{
            cell.textLabel?.text = Cities().city_names[indexPath.row]
        }
        return cell
    }
    
    
}
extension SelectYouCityViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citySearchBar.resignFirstResponder()
        if isSearching{
            selectedCity = searchingCities[indexPath.row]
            citySearchBar.text = selectedCity
            tableView.deselectRow(at: indexPath, animated: true)
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
            guard var array = UserDefaults.standard.value(forKey: "favCities") as? [String] else{return}
            array.append(selectedCity)
            Parse().setWeather(of: selectedCity) { (cityWeather) in
                DispatchQueue.main.async {
                    vc.cityLabel.text = cityWeather.cityName
                    vc.countryLabel.text = cityWeather.country
                    vc.temp = cityWeather.temperature
                    if let temp = vc.temp{
                        vc.temperatureLabel.text = "\(temp)°"
                    }
                    citiesWeather.append(cityWeather)
                    vc.feelLikesLabel.text = "\(cityWeather.feelsLike) °C"
                    vc.cloudCoverLabel.text = "\(cityWeather.cloudCover)"
                    vc.descriptionLabel.text = cityWeather.description.first?.uppercased()
                    vc.humidityLabel.text = "\(cityWeather.humidity) °C"
                    vc.windLabel.text = "\(cityWeather.windSpeed)" + " Km/H"
                    vc.visibilityLabel.text = "\(cityWeather.visibility)"
                    vc.setCurrentDate()
                }
            }
            vc.modalPresentationStyle = .fullScreen
            UserDefaults.standard.set(array, forKey: "favCities")
            UserDefaults.standard.synchronize()
            show(vc, sender: nil)
        }
        else{
            selectedCity = Cities().city_names[indexPath.row]
            citySearchBar.text = selectedCity
            tableView.deselectRow(at: indexPath, animated: true)
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
            guard var array = UserDefaults.standard.value(forKey: "favCities") as? [String] else{return}
            array.append(selectedCity)
            Parse().setWeather(of: selectedCity) { (cityWeather) in
                citiesWeather.append(cityWeather)
                DispatchQueue.main.async {
                    vc.cityLabel.text = cityWeather.cityName
                    vc.countryLabel.text = cityWeather.country
                    vc.temp = cityWeather.temperature
                    if let temp = vc.temp{
                        vc.temperatureLabel.text = "\(temp)°"
                    }
                    vc.feelLikesLabel.text = "\(cityWeather.feelsLike) °C"
                    vc.cloudCoverLabel.text = "\(cityWeather.cloudCover)"
                    vc.descriptionLabel.text = cityWeather.description.first?.uppercased()
                    vc.humidityLabel.text = "\(cityWeather.humidity) °C"
                    vc.windLabel.text = "\(cityWeather.windSpeed)" + " Km/H"
                    vc.visibilityLabel.text = "\(cityWeather.visibility)"
                    vc.setCurrentDate()
                }
            }
            vc.modalPresentationStyle = .fullScreen
            UserDefaults.standard.set(array, forKey: "favCities")
            UserDefaults.standard.synchronize()
            show(vc, sender: nil)
        }
       
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}
//MARK: UISearchBarDelegate
extension SelectYouCityViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearching = true
        searchTableView.isHidden = false
        searchingCities = Cities().city_names.filter({$0.contains(searchText)})
        searchTableView.reloadData()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
       dismiss(animated: true, completion: nil)
    }
}

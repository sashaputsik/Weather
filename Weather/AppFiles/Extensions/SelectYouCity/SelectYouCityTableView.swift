import Foundation
import UIKit

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
        }
        else{
            selectedCity = Cities().city_names[indexPath.row]
        }
        citySearchBar.text = selectedCity
        tableView.deselectRow(at: indexPath, animated: true)
        
        if citySearchBar.text != "" {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
            guard var array = UserDefaults.standard.value(forKey: "favCities") as? [String] else{return}
            array.append(selectedCity)
            vc.search(of: selectedCity)
            vc.modalPresentationStyle = .fullScreen
            UserDefaults.standard.set(array, forKey: "favCities")
            UserDefaults.standard.synchronize()
            show(vc, sender: nil)
        }
        else{
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
            vc.modalPresentationStyle = .fullScreen
            guard let array = UserDefaults.standard.value(forKey: "favCities") as? [String] else{return}
            guard let firstCity = array.first else{return}
            vc.search(of: firstCity)
            show(vc, sender: nil)
        }
    }
}

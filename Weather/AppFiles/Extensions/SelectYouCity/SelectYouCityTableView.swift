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
    }
}

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
                   vc.search(of: selectedCity)
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
                   vc.search(of: selectedCity)
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

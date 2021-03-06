import Foundation
import UIKit

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


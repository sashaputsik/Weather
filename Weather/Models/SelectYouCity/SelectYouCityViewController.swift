import UIKit

class SelectYouCityViewController: UIViewController {

    var isSearching = false
    var selectedCity = ""
    var searchingCities = [String]()
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.showsCancelButton = true
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.isHidden = true
        searchTableView.keyboardDismissMode = .onDrag
        citySearchBar.delegate = self
    }
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue){
        guard let vc = unwindSegue.destination as? FavCitiesTableViewController else{return}
        print("d")
    }

}

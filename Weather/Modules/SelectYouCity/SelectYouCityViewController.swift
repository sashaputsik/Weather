import UIKit

class SelectYouCityViewController: UIViewController {

    public var isSearching = false
    public var selectedCity = ""
    public var searchingCities = [String]()
    @IBOutlet private(set) var citySearchBar: UISearchBar!
    @IBOutlet private(set) var searchTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        citySearchBar.searchTextField.textColor = .white
        citySearchBar.showsCancelButton = true
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.isHidden = true
        searchTableView.keyboardDismissMode = .onDrag
        citySearchBar.delegate = self
    }
    @IBAction func unwind(for unwindSegue: UIStoryboardSegue){
        guard let vc = unwindSegue.destination as? FavCitiesTableViewController else{return}
        print(vc.self)
    }

}

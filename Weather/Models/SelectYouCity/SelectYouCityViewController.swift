import UIKit

class SelectYouCityViewController: UIViewController {

    var isSearching = false
    var searchingCities = [String]()
    var selectedCity = ""
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var segueMainViewButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        citySearchBar.delegate = self
        frameAndLayer()
        searchTableView.isHidden = true
        searchTableView.keyboardDismissMode = .onDrag
    }
    @IBAction func segueToMainView(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
        vc.search(city: selectedCity)
        vc.modalPresentationStyle = .fullScreen
        UserDefaults.standard.set(selectedCity, forKey: "selectedCity")
        show(vc, sender: nil)
    }
    
    func frameAndLayer(){
        segueMainViewButton.layer.cornerRadius = 5
        segueMainViewButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        segueMainViewButton.layer.shadowOpacity = 0.4
    }

}

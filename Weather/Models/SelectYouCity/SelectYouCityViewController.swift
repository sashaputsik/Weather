import UIKit

class SelectYouCityViewController: UIViewController {

    var isSearching = false
    var selectedCity = ""
    var searchingCities = [String]()
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var searchTableView: UITableView!
    @IBOutlet weak var segueMainViewButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.dataSource = self
        searchTableView.delegate = self
        searchTableView.isHidden = true
        searchTableView.keyboardDismissMode = .onDrag
        citySearchBar.delegate = self
        frameAndLayer()
    }
    @IBAction func segueToMainView(_ sender: UIButton) {
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
    func frameAndLayer(){
        segueMainViewButton.layer.cornerRadius = 5
        segueMainViewButton.layer.shadowOffset = CGSize(width: 1, height: 1)
        segueMainViewButton.layer.shadowOpacity = 0.4
    }

}

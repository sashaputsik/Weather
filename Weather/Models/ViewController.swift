import UIKit

class ViewController: UIViewController {
    let url = "http://api.weatherstack.com/current?access_key=31053ca50753efd7c09bf127addb619b&query="
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
    }

    func search(city: String){
        guard let urlString = URL(string: url+(city.replacingOccurrences(of: " ", with: "%20"))) else{return}
        let urlSession = URLSession.shared
        print(urlString)
        urlSession.dataTask(with: urlString) { (data, response, error) in
            guard let data = data else{return}
            print(data)
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else{return}
            if let current = json["current"] as? [String:Any]{
               print(current["feelslike"])
            }
        }.resume()
    }
}

extension ViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(city: searchBar.text!)
    }
}

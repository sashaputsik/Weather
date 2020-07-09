import UIKit

class FavCitiesTableViewController: UITableViewController {
    let url = "//http://api.weatherstack.com/current?access_key=80277e0892055782837a53be6b52070d&query="
    var favCities = [String]()
    @IBOutlet weak var footer: UIView!
    let refresher = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        footerFrameAndLayer()
        refresher.addTarget(self, action: #selector(valueUpdate), for: .valueChanged)
        tableView.addSubview(refresher)
        }
    override func viewWillAppear(_ animated: Bool) {
        guard let userDefaultFavCities = UserDefaults.standard.value(forKey: "favCities") as? [String] else{return}
        favCities = userDefaultFavCities
    }
    @objc private func valueUpdate(){
        tableView.reloadData()
        refresher.endRefreshing()
    }
    @IBAction func addedFavCities(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SelectYouCity") as? SelectYouCityViewController else{return}
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCities.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FavCitiesTableViewCell{
            cell.nameOfCityLabel.text = favCities[indexPath.row]
            guard let urlString = URL(string: url+(favCities[indexPath.row].replacingOccurrences(of: " ", with: "%20"))) else{return UITableViewCell()}
            let session = URLSession.shared
            session.dataTask(with: urlString) { (data, response, error) in
                guard let data = data else{return}
                guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else{return}
                
                if let current = json["current"]{
                    guard let discriptionImageUrl = current["weather_icons"] as? [String] else{return}
                    guard let url = URL(string: discriptionImageUrl.first!) else{return}
                    guard let imageData = try? Data(contentsOf: url) else{return}
                    guard let temp = current["temperature"] as? Int else{return}
                    DispatchQueue.main.async {
                        cell.descriptionImageView.image = UIImage(data: imageData)
                        cell.temperatureLabel.text = "\(temp)"
                        tableView.reloadData()
                    }
                }
            }.resume()
            return cell
        }
        return UITableViewCell()
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
        vc.search(of: favCities[indexPath.row])
        vc.modalPresentationStyle = .fullScreen
        show(vc, sender: nil)
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            favCities.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
            UserDefaults.standard.set(favCities, forKey: "favCities")
            UserDefaults.standard.synchronize()
            tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 95.0
    }
    


}

extension FavCitiesTableViewController{
    func footerFrameAndLayer(){
        footer.layer.borderWidth = 1
        footer.layer.borderColor = #colorLiteral(red: 0.8933945298, green: 0.87501646, blue: 0.6959577942, alpha: 1)
    }
}

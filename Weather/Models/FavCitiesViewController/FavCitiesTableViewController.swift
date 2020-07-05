import UIKit

class FavCitiesTableViewController: UITableViewController {
    let url = "http://api.weatherstack.com/current?access_key=31053ca50753efd7c09bf127addb619b&query="
    var favCities = [String]()
    let refresher = UIRefreshControl()
    override func viewDidLoad() {
        super.viewDidLoad()
        refresher.addTarget(self, action: #selector(valueUpdate), for: .valueChanged)
        tableView.addSubview(refresher)
        }
    @objc private func valueUpdate(){
        tableView.reloadData()
        refresher.endRefreshing()
        }
    override func viewWillAppear(_ animated: Bool) {
        guard let userDefaultFavCities = UserDefaults.standard.value(forKey: "favCities") as? [String] else{return}
        favCities = userDefaultFavCities
        tableView.reloadData()
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCities.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = favCities[indexPath.row]
        guard let urlString = URL(string: url+(favCities[indexPath.row].replacingOccurrences(of: " ", with: "%20"))) else{return UITableViewCell()}
        let session = URLSession.shared
        session.dataTask(with: urlString) { (data, response, error) in
            guard let data = data else{return}
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: AnyObject] else{return}
            if let current = json["current"]{
                DispatchQueue.main.async {
                    guard let temp = current["temperature"] as? Int else{return}
                    cell.detailTextLabel?.text = "\(temp)"
                }
            }
        }.resume()
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "MainView") as? ViewController else{return}
        vc.search(of: favCities[indexPath.row])
        print(favCities[indexPath.row])
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

}

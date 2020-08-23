import UIKit

class FavCitiesTableViewCell: UITableViewCell {

    @IBOutlet private(set) var nameOfCityLabel: UILabel!
    @IBOutlet private(set) var temperatureLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        nameOfCityLabel.layer.shadowOpacity = Appearence().shadowOpacity
        nameOfCityLabel.layer.shadowOffset = Appearence().shadowOffset
        temperatureLabel.layer.shadowOpacity = Appearence().shadowOpacity
        temperatureLabel.layer.shadowOffset = Appearence().shadowOffset
    }
}

private extension UITableViewCell{
    struct Appearence {
        let shadowOffset = CGSize(width: 1,
                                  height: 1)
        let shadowOpacity: Float = 0.4
    }
}

import UIKit

class FavCitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfCityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        nameOfCityLabel.layer.shadowOpacity = 0.4
        nameOfCityLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        temperatureLabel.layer.shadowOpacity = 0.4
        temperatureLabel.layer.shadowOffset = CGSize(width: 1, height: 1)
        descriptionImageView.layer.cornerRadius = descriptionImageView.frame.height/2
    }
}

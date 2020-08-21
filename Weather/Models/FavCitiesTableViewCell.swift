import UIKit

class FavCitiesTableViewCell: UITableViewCell {

    @IBOutlet weak var nameOfCityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var descriptionImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        nameOfCityLabel.layer.shadowOpacity = Float(Appearence().shadowOpacity)
        nameOfCityLabel.layer.shadowOffset = Appearence().shadowOffset
        temperatureLabel.layer.shadowOpacity = Float(Appearence().shadowOpacity)
        temperatureLabel.layer.shadowOffset = Appearence().shadowOffset
        descriptionImageView.layer.cornerRadius = descriptionImageView.frame.height/2
    }
}

private extension UITableViewCell{
    struct Appearence {
        let shadowOffset = CGSize(width: 1, height: 1)
        let shadowOpacity = 0.4
    }
}

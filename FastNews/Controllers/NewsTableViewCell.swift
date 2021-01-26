
import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleNewsLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 20
    }
}


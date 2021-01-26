
import UIKit
import SafariServices

class DetailViewController: UIViewController {
    
    @IBOutlet weak var scroller: UIScrollView!
    @IBOutlet weak var ImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var safariButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    var dateString: String?
    var titleStirng: String?
    var contentString: String?
    var urlString: String?
    var authorString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        scroller.contentSize = CGSize(width: scroller.contentSize.width, height: scroller.contentSize.height + 200)
    }
    
    private func setupUI() {
        dateLabel.text = dateString
        titleLabel.text = titleStirng
        authorLabel.text = authorString
        contentLabel.text = contentString!
        ImageView.layer.cornerRadius = 20
        safariButton.layer.cornerRadius = 15
    }
    @IBAction func safariButtonPressed(_ sender: UIButton) {
        if let url = URL(string: urlString ?? "") {
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
}

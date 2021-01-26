//
//import UIKit
//
//class ListNewsTableViewController: UITableViewController {
//
//    @IBOutlet var searchBarView: UISearchBar!
//
//    private var dateConverter = DateConverter()
//    var refresher = UIRefreshControl()
//     var items: [RSSItem] = []
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        navigationItem.titleView = searchBarView
//        loadData()
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
////        setupRefresher()
//    }
//    
//    //  MARK: - Table view data source
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return items.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
//        let item = items[indexPath.row]
//        let pulblishDate = item.publishDate
//        cell.descriptionLabel.text = pulblishDate
//        cell.titleLabel.text = item.name
//        DispatchQueue.main.async {
//            guard let url = URL(string: item.image) else {return}
//                cell.newsImage.setImage(urlImage: url)
//        }
//        return cell
//    }
//
//    //  MARK: - Configure prepare
//
////    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
////        if segue.identifier == "showDetail" {
////            if let indexPath = self.tableView.indexPathForSelectedRow {
////                let controller = segue.destination as! DetailViewController
////                let newDate = dateConverter.conver(input: filteredArticles[indexPath.row].publishedAt ?? "Unknowed time")
////                controller.dateString = newDate
////                controller.contentString = filteredArticles[indexPath.row].description
////                controller.titleStirng = filteredArticles[indexPath.row].title
////                controller.authorString = filteredArticles[indexPath.row].author
////                controller.urlString = filteredArticles[indexPath.row].url
////
////                DispatchQueue.main.async {
////                    guard let url = URL(string: self.filteredArticles[indexPath.row].urlToImage ?? "") else {return}
////                    controller.ImageView.setImage(urlImage: url)
////                }
////            }
////        }
////    }
//
//    private func loadData() {
//        let parser = Parser()
//        parser.parse(url: "https://lenta.ru/rss/top7") { (items) in
//            self.items = items
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//}
//
//
//
//
//

//
//  ListNewsTableViewController.swift
//  FastNews
//
//  Created by Максим Солнцев on 11/10/20.
//

import UIKit

class ListNewsTableViewController: UITableViewController {
    
    @IBOutlet var searchBarView: UISearchBar!
    private let output = ListNewsDelegate()
    private let networkManager = NewsDataSource()
    var filteredArticles: [Article] = []
    var dateConverter = DateConverter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.titleView = searchBarView
        searchBarView.delegate = self
        DispatchQueue.global().async { [weak self] in
            self?.networkManager.loadNews() {article in
                DispatchQueue.main.async {
                    self?.filteredArticles = article
                    self?.tableView.reloadData()
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupRefresher()
    }

    //  MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return filteredArticles.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        let article = filteredArticles[indexPath.row]
        let pulblishDate = dateConverter.conver(input: article.publishedAt ?? "")
        
        cell.descriptionLabel.text = pulblishDate
        cell.titleLabel.text = article.title
        DispatchQueue.main.async {
            guard let url = URL(string: article.urlToImage ?? "") else {return}
                cell.newsImage.setImage(urlImage: url)
        }
        return cell
    }
    
    @objc func refreshNews() {
        networkManager.loadNews() {article in
            DispatchQueue.main.async {
                self.filteredArticles = article
                self.tableView.reloadData()
                self.endingRefresh()
            }
        }
    }
}

//  MARK: - SearchBarDelegate Methods

 extension ListNewsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            filteredArticles = networkManager.articles
            return
        }
        filteredArticles = networkManager.articles.filter({ article -> Bool in
            article.title?.lowercased().contains(searchText.lowercased()) ?? false})
        tableView.reloadData()
    }
}



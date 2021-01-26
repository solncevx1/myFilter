//
//  NewsViewController.swift
//  FastNews
//
//  Created by Максим Солнцев on 1/23/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet private weak var horizontalScrollView: UIScrollView!
    @IBOutlet private weak var newsTableView: UITableView!
    @IBOutlet private weak var alphaButton: UIButton!
    @IBOutlet weak var sepiaButton: UIButton!
    @IBOutlet weak var tonarButton: UIButton!
    
    private var items: [RSSItem] = []
    private var itemsOfPage: [RSSItem] = []
    private var imageFromItems: [UIImageView] = []
    private var numberOfPage: Int = 10
    private var loadFlag: Bool = true
    private var filter: CIFilter!
    private var myFilter = ImageFilter()
    
    lazy var context: CIContext = {
        return CIContext(options: nil)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsTableView.delegate = self
        newsTableView.dataSource = self
        loadData()
        setupButton()
        
    }
    
    // MARK: - set filters
    
    @IBAction func setAlpha(_ sender: UIButton) {
        DispatchQueue.main.async {
            self.myFilter.setFilter(images: self.imageFromItems, filterKey: .Tonal)
            self.newsTableView.reloadData()
        }
    }
    
    @IBAction func setSepia(_ sender: UIButton) {
        
        myFilter.setFilter(images: imageFromItems, filterKey: .Mono)
        
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    @IBAction func setTonar(_ sender: UIButton) {
        myFilter.setFilter(images: imageFromItems, filterKey: .Noir)
        
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    
    private func loadData() {
        let parser = Parser()
        parser.parse(url: "https://lenta.ru/rss/articles") { (items) in
            self.items = items
            
            for i in 0...self.numberOfPage {
                self.itemsOfPage.append(items[i])
            }
            
            DispatchQueue.main.async {
                for item in self.items {
                    guard let url = URL(string: item.image) else { return }
                    let image = UIImageView()
                    image.setImage(urlImage: url)
                    self.imageFromItems.append(image)
                }
            }
            
            DispatchQueue.main.async {
                self.newsTableView.reloadData()
            }
        }
    }
    
    private func setupButton() {
        let image = UIImage(named: "dog")
        let newImageWithSepia = image?.setSepia()
        let newImageWithBlur = image?.setBlur()
        let newImageWithTonar = image?.setTonar()
        
        self.sepiaButton.setBackgroundImage(newImageWithSepia, for: .normal)
        self.alphaButton.setBackgroundImage(newImageWithBlur, for: .normal)
        self.tonarButton.setBackgroundImage(newImageWithTonar, for: .normal)
    }
}

// MARK - TableView delegate

extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        itemsOfPage.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewsTableViewCell
        let item = itemsOfPage[indexPath.row]
        cell.titleNewsLabel.text = item.name
        DispatchQueue.main.async {
            cell.newsImage.image = self.imageFromItems[indexPath.row].image
        }
        
        if indexPath.row == self.items.count - 1 {
            loadData()
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == itemsOfPage.count - 1  {
            loadMore()
        }
    }
    
    private func loadMore() {
        
        for _ in 0...5 {
            var lastItem = itemsOfPage.count
            lastItem += 1
            itemsOfPage.append(items[lastItem])
        }
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
        
    }
}

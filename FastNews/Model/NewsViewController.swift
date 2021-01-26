//
//  NewsViewController.swift
//  FastNews
//
//  Created by Максим Солнцев on 1/23/21.
//

import UIKit

class NewsViewController: UIViewController {
    
    @IBOutlet private weak var newsTableView: UITableView!
    @IBOutlet private weak var alphaButton: UIButton!
    @IBOutlet private weak var tonarButton: UIButton!
    @IBOutlet private weak var tonalButton: UIButton!
    
    private var items: [RSSItem] = []
    private var itemsOfPage: [RSSItem] = []
    private var imageFromItems: [UIImageView] = []
    private var numberOfPage: Int = 3
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
    
    @IBAction func setTonal(_ sender: UIButton) {
        
            myFilter.setFilter(images:imageFromItems , filterKey: .Tonal)
        
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
    
    @IBAction func setMono(_ sender: UIButton) {
        
        myFilter.setFilter(images:imageFromItems , filterKey: .Mono)

        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }

    @IBAction func setNoir(_ sender: UIButton) {
        
        myFilter.setFilter(images:imageFromItems , filterKey: .Tonal)

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
        let imageView = UIImageView()
        imageView.image = UIImage(named: "dog")
//        let newImageWithSepia = image?.setSepia()
//        let newImageWithBlur = image?.setBlur()
//         myFilter.setFilter(inpurImageView: imageView, filterKey: .Noir)
        tonalButton.setBackgroundImage(imageView.image, for: .normal)
        
//        self.tonalButton.setBackgroundImage(newImageWithSepia, for: .normal)
//
//        self.tonarButton.setBackgroundImage(newImageWithTonar, for: .normal)
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
        

        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y + scrollView.frame.size.height > scrollView.contentSize.height {
                self.loadMore()
        }
    }

    private func loadMore() {
        for _ in 0...3 {
            var lastItem = itemsOfPage.count - 1
            lastItem += 1
            itemsOfPage.append(items[lastItem])
        }
        DispatchQueue.main.async {
            self.newsTableView.reloadData()
        }
    }
}

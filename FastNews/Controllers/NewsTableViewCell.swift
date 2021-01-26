//
//  NewsTableViewCell.swift
//  FastNews
//
//  Created by Максим Солнцев on 11/10/20.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var newsImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        newsImage.layer.cornerRadius = 15
    }
}

extension NewsTableViewCell {
    
}

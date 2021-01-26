//
//  RefreshController.swift
//  FastNews
//
//  Created by Максим Солнцев on 11/11/20.
//

import Foundation
import UIKit

var refresher = UIRefreshControl()

extension ListNewsTableViewController {
    func setupRefresher(){
        refresher.attributedTitle = NSAttributedString(string: "Обновляем...")
        refresher.addTarget(self, action: #selector(refreshNews), for: UIControl.Event.valueChanged)
        tableView.insertSubview(refresher, at: 0)
    }
    
    func endingRefresh () {
        refresher.endRefreshing()
    }
}

//
//  HomeTableViewController.swift
//  cmbCodeChallenge
//
//  Created by Kayla Galway on 3/29/17.
//  Copyright © 2017 Kayla Galway. All rights reserved.
//

import Foundation
import UIKit

class HomeTableViewController: UITableViewController, HomeViewModelDelegate {
    
    var viewModel = HomeViewModel()
    
    override func viewDidLoad() {
        viewModel.delegate = self
        viewModel.fetchTableViewData()
    }
    
    func dataDidLoad() {
        tableView.reloadData()
    }
    
    func imageDidLoad(atIndexPath indexPath: IndexPath) {
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let isValidImageIndex = (indexPath.row <= viewModel.teammateArray.count) && (viewModel.teammateArray.count > 0)
        guard let indexPathArray = tableView.indexPathsForVisibleRows else {
            return cell
        }
        let cellIsVisible = indexPathArray.contains(indexPath)
        if isValidImageIndex, cellIsVisible {
            cell.imageView?.image = viewModel.image(forIndexPath: indexPath)
        }
        cell.textLabel?.text = viewModel.teammateArray[indexPath.row].firstName
        return cell
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teammateArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    
}

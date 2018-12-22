//
//  TableViewController.swift
//  AddSearchTableViewTutorial
//
//  Created by andyron on 2017/3/30.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, UISearchResultsUpdating {

    let tableData = ["One", "Two", "Three", "Twenty-One"]
    
    var filteredTableData = [String]()
    var resultSearchController = UISearchController()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            // 搜索页面是否是灰色
            controller.dimsBackgroundDuringPresentation = false
            controller.searchBar.sizeToFit()
            
            // 把搜索框放在table头部，当然也可放在tableFooterView
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
        self.tableView.reloadData()
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (self.resultSearchController.isActive) {
            return self.filteredTableData.count
        } else {
            return self.tableData.count
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        if (self.resultSearchController.isActive) {
            cell.textLabel?.text = self.filteredTableData[indexPath.row]
        } else {
            cell.textLabel?.text = self.tableData[indexPath.row]
        }
        

        return cell
    }
    
    //MARK: - UISearchResultsUpdating
    func updateSearchResults(for searchController: UISearchController) {
        
        filteredTableData.removeAll(keepingCapacity: false)
        
        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text!)
        
        let array = (tableData as NSArray).filtered(using: searchPredicate)
        filteredTableData = array as! [String]
        
        self.tableView.reloadData()
    }

}

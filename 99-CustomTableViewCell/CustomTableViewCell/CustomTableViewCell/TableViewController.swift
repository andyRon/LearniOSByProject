//
//  ViewController.swift
//  CustomTableViewCell
//
//  Created by andyron<http://andyron.com> on 2018/5/26.
//  Copyright © 2018年 andyron. All rights reserved.
//

import UIKit

struct CellData {
    let image: UIImage?
    let message: String?
}

class TableViewController: UITableViewController {

    var data = [CellData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        data = [CellData.init(image: #imageLiteral(resourceName: "blue"), message: "How make ?"), CellData.init(image: #imageLiteral(resourceName: "blue"), message: "How make ?"), CellData.init(image: #imageLiteral(resourceName: "blue"), message: "How make ?")]
        
        self.tableView.register(CustomCell.self, forCellReuseIdentifier: "custom")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "custom") as! CustomCell
        cell.mainImage = data[indexPath.row].image
        cell.message = data[indexPath.row].message
        
        return cell
    }
    
    override  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }


}


//
//  FBMeVC.swift
//  FacebookMe
//
//  Created by Andy Ron on 2018/8/7.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class FBMeVC: UITableViewController {

    typealias RowModel = [String: String]
    
    var user: FBMeUser {
        get {
            return FBMeUser(name: "AndyRon", education: "NJFU")
        }
    }
    
    var tableViewDataSource: [[String: Any]] {
        get {
            return TableKeys.populate(withUser: user)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = {
            let view = UITableView(frame: .zero, style: .grouped)
            view.register(FBMeBaseCell.self, forCellReuseIdentifier: FBMeBaseCell.identifier)
            return view
        }()
        
       super.view.backgroundColor = Specs.color.mygray
        
        title = "Facebook"
        navigationController?.navigationBar.barTintColor = Specs.color.tint
        
        tableView.delegate = self
        tableView.dataSource = self
//        view.addSubview(tableView)
        
        // Set layout for tableView.
        tableView.translatesAutoresizingMaskIntoConstraints = false
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
//        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[tableView]-0-|", options: .directionLeadingToTrailing, metrics: nil, views: ["tableView": tableView]))
    }
    
    func rows(at section: Int) -> [Any] {
        return tableViewDataSource[section][TableKeys.Rows] as! [Any]
    }
    
    func title(at section: Int) -> String? {
        return tableViewDataSource[section][TableKeys.Section] as? String
    }
    
    func rowModel(at indexPath: IndexPath) -> RowModel {
        return rows(at: indexPath.section)[indexPath.row] as! RowModel
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return tableViewDataSource.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return rows(at: section).count
    }
    
    override func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return title(at: section)
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let modelForRow = rowModel(at: indexPath)
        var cell = UITableViewCell()
        
        guard let title = modelForRow[TableKeys.Title] else {
            return cell
        }
        
        if title == user.name {
            cell = UITableViewCell.init(style: .subtitle, reuseIdentifier: nil)
        } else {
            cell = tableView.dequeueReusableCell(withIdentifier: FBMeBaseCell.identifier, for: indexPath)
        }
        
        cell.textLabel?.text = title
        
        if let imageName = modelForRow[TableKeys.ImageName] {
            cell.imageView?.image = UIImage(named: imageName)
        } else if title != TableKeys.logout {
            cell.imageView?.image = UIImage(named: Specs.imageName.placeholder)
        }
        
        if title == user.name {
            cell.detailTextLabel?.text = modelForRow[TableKeys.SubTitle]
        }
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let modelForRow = rowModel(at: indexPath)
        
        guard let title = modelForRow[TableKeys.Title] else {
            return 0.0
        }
        
        if title == user.name {
            return 64.0
        } else {
            return 44.0
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let modelForRow = rowModel(at: indexPath)
        
        guard let title = modelForRow[TableKeys.Title] else {
            return
        }
        
        if title == TableKeys.seeMore || title == TableKeys.addFavorites {
            cell.textLabel?.textColor = Specs.color.tint
            cell.accessoryType = .none
        } else if title == TableKeys.logout {
            cell.textLabel?.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
            cell.textLabel?.textColor = Specs.color.red
            cell.textLabel?.textAlignment = .center
            cell.accessoryType = .none
        } else {
            cell.accessoryType = .disclosureIndicator
        }
    }

}

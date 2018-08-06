//
//  DetailTableVC.swift
//  Artistry
//
//  Created by Andy Ron on 2018/8/5.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class DetailTableVC: UITableViewController {

    var selectedArtist: Artist!
    
    let moreInfoText = "Select For More Info >"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = selectedArtist.name
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
        NotificationCenter.default.addObserver(forName: .UIContentSizeCategoryDidChange, object: .none, queue: OperationQueue.main) { [weak self] _ in
            self?.tableView.reloadData()
        }
    }


    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return selectedArtist.works.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WorkTableViewCell

        let work = selectedArtist.works[indexPath.row]
        
        cell.workTitleLabel.text = work.title
        cell.workImageView.image = work.image
        
        cell.workTitleLabel.backgroundColor = UIColor(white: 204/255, alpha: 1)
        cell.workTitleLabel.textAlignment = .center
        cell.moreInfoTextView.textColor = UIColor(white: 114 / 255, alpha: 1)
        cell.selectionStyle = .none
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        
        cell.workTitleLabel.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline)
        cell.moreInfoTextView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.footnote)
        
        return cell
    }
 

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? WorkTableViewCell else {
            return
        }
        
        var work = selectedArtist.works[indexPath.row]
        
        work.isExpanded = !work.isExpanded
        selectedArtist.works[indexPath.row] = work
        
        cell.moreInfoTextView.text = work.isExpanded ? work.info : moreInfoText
        cell.moreInfoTextView.textAlignment = work.isExpanded ? .left : .center
        
        tableView.beginUpdates()
        tableView.endUpdates()
        
        tableView.scrollToRow(at: indexPath, at: .top, animated: true)
    }

}

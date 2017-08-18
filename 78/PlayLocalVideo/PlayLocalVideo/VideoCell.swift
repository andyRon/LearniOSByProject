//
//  VideoCell.swift
//  PlayLocalVideo
//
//  Created by andyron on 2017/8/18.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {

    @IBOutlet var previewImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var sourceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

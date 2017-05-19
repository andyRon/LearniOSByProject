//
//  SocialTableViewCell.swift
//  SocialSharingDemo
//
//  Created by andyron on 2017/5/19.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class SocialTableViewCell: UITableViewCell {

    @IBOutlet var featuredImageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var shareButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

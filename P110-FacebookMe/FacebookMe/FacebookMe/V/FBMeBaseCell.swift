//
//  FBMeBaseCell.swift
//  FacebookMe
//
//  Created by Andy Ron on 2018/8/8.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class FBMeBaseCell: UITableViewCell {
    static let identifier = "FBMeBaseCell"

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = Specs.color.white
        textLabel?.textColor = Specs.color.black
        textLabel?.font = Specs.font.large
        
        detailTextLabel?.font = Specs.font.small
        detailTextLabel?.textColor = Specs.color.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

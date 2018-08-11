//
//  FBMeUser.swift
//  FacebookMe
//
//  Created by Andy Ron on 2018/8/8.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import Foundation

class FBMeUser {
    var name: String
    var avatarName: String
    var education: String
    
    init(name: String, avatarName: String = "AndyRon", education: String) {
        self.name = name
        self.avatarName = avatarName
        self.education = education
    }
}

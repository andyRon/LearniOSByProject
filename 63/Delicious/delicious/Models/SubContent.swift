//
//  SubContent.swift
//  Delicious
//
//  Created by andyron on 2017/4/20.
//  Copyright © 2017年 Demo. All rights reserved.
//

import Foundation
import UIKit

class SubContent {
    
    var photo: String?
    var photoWidth: CGFloat?
    var photoHeight: CGFloat?
    var text: String?
    
    init(photo: String, photoWidth: CGFloat, photoHeight: CGFloat, text: String) {
        self.photo = photo
        self.photoWidth = photoWidth
        self.photoHeight = photoHeight
        self.text = text
    }
}

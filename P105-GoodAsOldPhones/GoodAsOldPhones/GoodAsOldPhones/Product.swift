//
//  Product.swift
//  GoodAsOldPhones
//
//  Created by Andy Ron on 2018/8/3.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import Foundation

class Product {
    var name: String?
    var cellImageName: String?
    var fullscreenImageName: String?
    
    init(name: String, cellImageName: String, fullscreenImageName: String) {
        self.name = name
        self.cellImageName = cellImageName
        self.fullscreenImageName = fullscreenImageName
    }
}

//
//  Article.swift
//  Delicious
//
//  Created by andyron on 2017/4/20.
//  Copyright © 2017年 Demo. All rights reserved.
//

import Foundation
import UIKit

class Article {
    
    var title: String?
    var mainContent: String?
    
    var coverPhoto: String?
    var coverPhotoWidth: CGFloat?
    var coverPhotoHeight: CGFloat?
    
    var mealType: String?
    var mealPrice: Int?
    
    var authorDisplayName: String?
    var authorUsername: String?
    
    var restaurantName: String?
    var restaurantAddress: String?
    var restaurantLatitude: Double?
    var restaurantLongitude: Double?
    
    var subContents = [SubContent]()
    
    init(title: String, mainContent: String, coverPhoto: String, coverPhotoWidth: CGFloat, coverPhotoHeight: CGFloat, mealType: String, mealPrice: Int) {
        self.title = title
        self.mainContent = mainContent
        self.coverPhoto = coverPhoto
        self.coverPhotoWidth = coverPhotoWidth
        self.coverPhotoHeight = coverPhotoHeight
        self.mealType = mealType
        self.mealPrice = mealPrice
    }
    
}

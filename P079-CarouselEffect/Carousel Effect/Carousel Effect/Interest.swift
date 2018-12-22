//
//  Interest.swift
//  Carousel Effect
//
//  Created by andyron on 2017/8/19.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class Interest
{
    var title = ""
    var featuredImage: UIImage!
    
    init(title: String,  featuredImage: UIImage!)
    {
        self.title = title
        self.featuredImage = featuredImage
        
    }
    
    static func createInterests() -> [Interest]
    {
        return [
            Interest(title: "🐱🐱🐱🐱，Look",featuredImage: UIImage(named: "cat")!),
            Interest(title: "🐱🐱🐱,😌",  featuredImage: UIImage(named: "cat2")!),
            Interest(title: "flower 🌸",featuredImage: UIImage(named: "花")!),
            Interest(title: "lonely 🌳", featuredImage: UIImage(named: "树")!),
            Interest(title: "🐶 ",  featuredImage: UIImage(named: "狗")!),
            Interest(title: "One Piece", featuredImage: UIImage(named: "海贼王")!),
        ]
    }
}

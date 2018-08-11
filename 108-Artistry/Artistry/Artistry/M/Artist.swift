//
//  Artist.swift
//  Artistry
//
//  Created by Andy Ron on 2018/8/5.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

struct Artist {
    let name: String
    let bio: String
    let image: UIImage
    var works: [Work]
    
    init(name: String, bio: String, image: UIImage, works: [Work]) {
        self.name = name
        self.bio = bio
        self.image = image
        self.works = works
    }
    
    static func artistsFromBundle() -> [Artist] {
        var artists = [Artist]()
        
        
        guard let url = Bundle.main.url(forResource: "artists", withExtension: "json") else {
            return artists
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let rootObj = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any] else {
                return artists
            }
            
            
            guard let artistObjs = rootObj["artists"] as? [[String : AnyObject]] else {
                return artists
            }
            
            for artistObj in artistObjs {
                if let name = artistObj["name"] as? String,
                let bio = artistObj["bio"] as? String,
                let imageName = artistObj["image"] as? String,
                let image = UIImage(named: imageName),
                let worksObj = artistObj["works"] as? [[String : String]] {
                    var works = [Work]()
                    for workObj in worksObj {
                        if let workTitle = workObj["title"],
                        let workImageName = workObj["image"],
                        let workImage = UIImage(named: workImageName + ".jpg"),
                        let info = workObj["info"] {
                            works.append(Work(title: workTitle,image: workImage,info: info, isExpanded: false))
                        }
                    }
                    let artist = Artist(name: name, bio: bio, image: image, works: works)
                    artists.append(artist)
                }
            }
        } catch  {
            return artists
        }
        
        return artists
    }
}

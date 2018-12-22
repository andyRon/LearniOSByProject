//
//  VideoClip.swift
//  TravelVlogs
//
//  Created by [Andy Ron](https://github.com/andyRon) on 2018/11/7.
//  Copyright © 2018 [Andy Ron](https://github.com/andyRon). All rights reserved.
//

import UIKit

class VideoClip: NSObject {
    let url: URL
    
    init(url: URL) {
        self.url = url
        super.init()
    }
    
    class func allClip() -> [VideoClip] {
        var clips: [VideoClip] = []
        
        let names = ["newYorkFlip-clip", "bulletTrain-clip", "monkey-clip", "shark-clip"]
        for name in names {
            let urlPath = Bundle.main.path(forResource: name, ofType: "mp4")!
            let url = URL(fileURLWithPath: urlPath)
            
            let clip = VideoClip(url: url)
            clips.append(clip)
        }
        return clips
    }
}

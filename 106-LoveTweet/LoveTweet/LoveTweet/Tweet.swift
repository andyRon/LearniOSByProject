//
//  Tweet.swift
//  LoveTweet
//
//  Created by Andy Ron on 2018/8/4.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import Foundation

struct Tweet {
    var gender: Gender
    var name: String
    var age: Int
    var work: String
    var salary: String
    var isStraight: Bool   // 直男 直女
    
    var interestedGender: String {
        switch gender {
        case .Female:
            return isStraight ? "Men" : "Women"
        case .Male:
            return isStraight ? "Women" : "Men"
        }
    }
    
    var info: String {
        return "Hi, I am \(name). As a \(age)-year-old \(work) earning \(salary)/year, I am interested in \(interestedGender). Feel free to contact me!"
    }
}

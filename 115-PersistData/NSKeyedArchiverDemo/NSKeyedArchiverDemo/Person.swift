//
//  Person.swift
//  NSKeyedArchiverDemo
//
//  Created by Andy Ron on 2018/8/23.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import Foundation

class Person: NSObject, NSCoding {
    var name: String
    var sex: String
    var age: Int
    
    init(name: String, sex: String, age: Int) {
        self.name = name
        self.sex = sex
        self.age = age
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.sex, forKey: "sex")
        aCoder.encode(self.age, forKey: "age")

    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.sex = aDecoder.decodeObject(forKey: "sex") as! String
        self.age = aDecoder.decodeObject(forKey: "age") as! Int
        
    }
    
    
}

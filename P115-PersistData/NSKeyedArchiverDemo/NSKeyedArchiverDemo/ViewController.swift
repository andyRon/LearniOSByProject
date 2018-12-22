//
//  ViewController.swift
//  NSKeyedArchiverDemo
//
//  Created by Andy Ron on 2018/8/23.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        save()
//        get()
        
    }

    func save() {
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let file = path?.appendingPathComponent("person.data").absoluteString
        let person = Person(name: "Andy", sex: "male", age: 100)
        
        print(NSKeyedArchiver.archiveRootObject(person, toFile: file!))
        
    }

    
    func get() {
        let fileManager = FileManager.default
        let path = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        let file = path?.appendingPathComponent("person.data").absoluteString
        
        print(file)
        if let person:Person = NSKeyedUnarchiver.unarchiveObject(withFile: file!) as? Person {
            print(person.name, person.sex, person.age)
        }
        
    
    
    }

}


//
//  ViewController.swift
//  localizationsDemo
//
//  Created by andyron on 2017/8/12.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var label: UILabel!
    
    @IBOutlet var label2: UILabel!
    
    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        self.label.text = NSLocalizedString("labelName", comment: "Label")
//        self.label2.text = NSLocalizedString("labelName", tableName: "andy", bundle: Bundle.main, value: "", comment: "Label")
//        self.imageView.image = UIImage(named: NSLocalizedString("Swift_Logo", comment: ""))

        
        self.label.text = "labelName".localized
        self.label2.text = "labelName".localized(tableName: "andy")
        self.imageView.image = UIImage(named: "Swift_Logo".localized)
        
    }


}

extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(withComment:String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
    
    func localized(tableName: String) -> String{
        return NSLocalizedString(self, tableName: tableName, bundle: Bundle.main, value: "", comment: "")
    }
}


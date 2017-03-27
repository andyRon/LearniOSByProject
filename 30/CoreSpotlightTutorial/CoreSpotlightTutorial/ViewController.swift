//
//  ViewController.swift
//  CoreSpotlightTutorial
//
//  Created by andyron on 2017/3/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import CoreSpotlight
import MobileCoreServices

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var textField: UITextField!
    
    let identifier = "MyIdentifier"

    override func viewDidLoad() {
        super.viewDidLoad()

        textField.delegate = self
    }

    @IBAction func AddItemToCoreSpotlight(_ sender: AnyObject) {
        let attributeSet = CSSearchableItemAttributeSet(itemContentType: kUTTypeText as String)
        attributeSet.title = textField.text
        attributeSet.contentDescription = "CoreSpotLight tutorial"
        
        let item = CSSearchableItem(uniqueIdentifier: identifier, domainIdentifier: "cn.andyron", attributeSet: attributeSet)
        CSSearchableIndex.default().indexSearchableItems([item]) {
            (error: Error?) in
            
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully indexed")
            }
        }
    }
    
    @IBAction func RemoveItemFromCoreSpotlight(_ sender: AnyObject) {
        CSSearchableIndex.default().deleteSearchableItems(withIdentifiers: [identifier]) {
            (error: Error?) in
            
            if let error = error {
                print("Indexing error: \(error.localizedDescription)")
            } else {
                print("Search item successfully removed")
            }
        }
        
    }

    // 去掉键盘的return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    
    
    
}


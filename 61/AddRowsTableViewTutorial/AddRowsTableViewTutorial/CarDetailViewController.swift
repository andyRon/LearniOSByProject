//
//  CarDetailViewController.swift
//  AddRowsTableViewTutorial
//
//  Created by andyron on 2017/4/19.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class CarDetailViewController: UIViewController {

    var name: String = ""
    
    @IBOutlet var carName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "doneSegue" {
            name = carName.text!
        }
    }
    
}

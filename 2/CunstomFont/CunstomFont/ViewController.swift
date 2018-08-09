//
//  ViewController.swift
//  CunstomFont
//
//  Created by andyron on 2016/12/19.
//  Copyright © 2016年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var data = ["LearniOSByProject", "来源 30 Days Swift","随便打点字", "湖人总冠军", "来点特殊符号","≠♥★™⌘≅", "微博 @Andy_Ron"]
    
    var fontNames = ["MFTongXin_Noncommercial-Regular", "MFJinHei_Noncommercial-Regular", "MFZhiHei_Noncommercial-Regular", "edundot", "Gaspar Regular"]
    
    var fontRowIndex = 0

    @IBOutlet weak var fontTableView: UITableView!
    @IBOutlet weak var changeFontButton: UIButton!
    
    @IBAction func changeFontDidTouch(_ sender: AnyObject) {
        
        fontRowIndex = (fontRowIndex + 1) % 5
        
        fontTableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        fontTableView.delegate = self
        fontTableView.dataSource = self
        
        changeFontButton.layer.cornerRadius = 55
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = fontTableView.dequeueReusableCell(withIdentifier: "FontCell", for: indexPath)
        
        let text = data[indexPath.row]
        
        cell.textLabel?.text = text
        cell.textLabel?.textColor = UIColor.white
        cell.textLabel?.font = UIFont(name: self.fontNames[fontRowIndex], size: 21)
        
        return cell
    }
}


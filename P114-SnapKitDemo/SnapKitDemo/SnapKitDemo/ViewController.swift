//
//  ViewController.swift
//  SnapKitDemo
//
//  Created by Andy Ron on 2018/8/17.
//  Copyright © 2018年 Andy Ron. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let displayView = UIView()
        let keyboardView = UIView()
        displayView.backgroundColor = .black
        self.view.addSubview(displayView)
        self.view.addSubview(keyboardView)
        
        
        displayView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view)
            make.right.left.equalTo(self.view)
            make.height.equalTo(keyboardView).multipliedBy(0.3)
        }
        
        keyboardView.snp.makeConstraints { (make) in
            make.top.equalTo(displayView.snp.bottom)
            make.bottom.equalTo(self.view)
            make.left.right.equalTo(self.view)
        }
        
        let displayNum = UILabel()
        displayNum.text = "0"
        displayNum.font = UIFont(name: "HeiTi SC", size: 70)
        displayNum.textColor = .white
        displayNum.textAlignment = .right
        self.view.addSubview(displayNum)
        displayNum.snp.makeConstraints { (make) in
            make.right.left.equalTo(displayView).offset(-10)
            make.bottom.equalTo(displayView.snp.bottom).offset(-10)
        }
        
        let keys:Array = [
            "AC","+/-","%","÷"
            ,"7","8","9","x"
            ,"4","5","6","-"
            ,"1","2","3","+"
            ,"0","?",".","="]
        
        var indexOfKeys = 0
        for key in keys {
            indexOfKeys = indexOfKeys + 1
            let rowNum = (indexOfKeys % 4 == 0) ? indexOfKeys/4 : (indexOfKeys/4 + 1)
            let colNum = (indexOfKeys % 4 == 0) ? 4 : indexOfKeys % 4
            
            let keyView = UIButton(type: .custom)
            keyboardView.addSubview(keyView)
            keyView.setTitle(key, for: .normal)
            keyView.setTitleColor(.black, for: .normal)
            keyView.layer.borderWidth = 1
            keyView.layer.borderColor = UIColor.black.cgColor
            keyView.titleLabel?.font = UIFont(name: "Arial-BoldItalicMT", size: 30)
            
            
            keyView.snp.makeConstraints { (make) in
                
                if key == "0" {
                    keyView.snp.makeConstraints({ (make) in
                        make.height.equalTo(keyboardView.snp.height).multipliedBy(0.2)
                        make.width.equalTo(keyboardView.snp.width).multipliedBy(0.5)
                        make.left.equalTo(keyboardView.snp.left)
                        make.lastBaseline.equalTo(keyboardView.snp.lastBaseline).multipliedBy(0.92)
                    })
                } else if key == "?" {
                    keyView.removeFromSuperview()
                } else {
                    make.width.equalTo(keyboardView.snp.width).multipliedBy(0.25)
                    make.height.equalTo(keyboardView.snp.height).multipliedBy(0.2)
                    
                    switch rowNum {
                    case 1:
                        make.lastBaseline.equalTo(keyboardView.snp.lastBaseline).multipliedBy(0.12)
                    case 2:
                        make.lastBaseline.equalTo(keyboardView.snp.lastBaseline).multipliedBy(0.32)
                    case 3:
                        make.lastBaseline.equalTo(keyboardView.snp.lastBaseline).multipliedBy(0.52)
                    case 4:
                        make.lastBaseline.equalTo(keyboardView.snp.lastBaseline).multipliedBy(0.72)
                    case 5:
                        make.lastBaseline.equalTo(keyboardView.snp.lastBaseline).multipliedBy(0.92)
                        
                    default:
                        break
                    }
                    
                    switch colNum {
                    case 1:
                        make.left.equalTo(keyboardView.snp.left)
                    case 2:
                        make.right.equalTo(keyboardView.snp.centerX)
                    case 3:
                        make.left.equalTo(keyboardView.snp.centerX)
                    case 4:
                        make.right.equalTo(keyboardView.snp.right)
                    default:
                        break
                    }
                }
            }
        }
        
        
    }




}


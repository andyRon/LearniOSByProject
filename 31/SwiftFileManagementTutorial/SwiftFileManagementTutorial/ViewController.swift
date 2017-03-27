//
//  ViewController.swift
//  SwiftFileManagementTutorial
//
//  Created by andyron on 2017/3/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var fileManager = FileManager()
    var tmpDir = NSTemporaryDirectory()
    let fileName = "sample.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    func enumerateDirectory() -> String? {
        
        let filesInDirectory = try? fileManager.contentsOfDirectory(atPath: tmpDir) 
        
        if let files = filesInDirectory {
            if files.count > 0 {
                if files[0] == fileName {
                    print("sample.txt found")
                    return files[0]
                } else {
                    print("File not found")
                    return nil
                }
            }
        }
        return nil
    }


    @IBAction func createFile(_ sender: UIButton) {
        let path = tmpDir.appending(fileName)
        let contentsOfFile = "Sample Text"
        
        if ((try? contentsOfFile.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)) != nil) {
           // if let errorMessage = error {
                print("Failed to create file")
              //  print("\(errorMessage)")
            //}
        } else {
            print("File sample.txt created at tmp directory")
        }
    }

    @IBAction func listDirectory(_ sender: UIButton) {
        
        let isFileInDir = enumerateDirectory() ?? "Empty"
        print("Contents of Directory = \(isFileInDir)")
    }
    
    @IBAction func viewFileContent(_ sender: UIButton) {
        let isFileInDir = enumerateDirectory() ?? ""
        
        let path = tmpDir.appending(isFileInDir)
        let contentsOfFile = try! NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue) as? NSString
        
        if let content = contentsOfFile {
            print("Content of file = \(content)")
        } else {
            print()
        }
    }
    
    @IBAction func deleteFile(_ sender: UIButton) {
        
        if let isFileInDir = enumerateDirectory() {
            let path = tmpDir.appending(isFileInDir)
            try? fileManager.removeItem(atPath: path)
        } else {
            print("No file found")
        }
        
    }
}


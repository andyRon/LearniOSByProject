//
//  TableViewController.swift
//  SpellingCheckerTutorial
//
//  Created by andyron on 2017/3/25.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    let words = ["devalopment", "development","devellopment", "apple", "appple", "human", "happy"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return words.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = words[indexPath.row]
        cell.textLabel?.backgroundColor = UIColor.clear

        return cell
    }
 
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)!
        
        if wordIsSpelledCorrect(word: (cell.textLabel?.text)!) {
            cell.backgroundColor = UIColor.green
        } else {
            cell.backgroundColor = UIColor.red
        }
        tableView.reloadData()
    }
    
    func wordIsSpelledCorrect(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSMakeRange(0, word.characters.count)
        let wordRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        return wordRange.location == NSNotFound
    }


}

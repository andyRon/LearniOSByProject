//
//  TableViewController.swift
//  XMLParserTutorial
//
//  Created by andyron on 2017/3/27.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController, XMLParserDelegate {
    
    var books: [Book] = []
    var eName: String = ""
    var bookTitle = ""
    var bookAuthor = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        if let path = Bundle.main.url(forResource: "Books", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        // Configure the cell...
        
        let book = books[indexPath.row]
        cell.textLabel?.text = book.bookTitle
        cell.detailTextLabel?.text = book.bookAuthor

        return cell
    }
    
    // MARK: - XMLParserDelegate
    // 解析XMl元素开始时
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("开始 \(elementName)")
        eName = elementName
        if elementName == "book" {
            bookTitle = ""
            bookAuthor = ""
        }
    }
    // 正在解析XMl元素
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("ing \(eName)")
        let data = string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        
        if (!data.isEmpty) {
            if eName == "title" {
                bookTitle += data
            } else if eName == "author" {
                bookAuthor += data
            }
        }
    }
    // 结束解析XMl元素
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("结束 \(elementName)")
        if elementName == "book" {
            
            let book = Book()
            book.bookTitle = bookTitle
            book.bookAuthor = bookAuthor
            
            books.append(book)
        }
    }
    
    
   
}

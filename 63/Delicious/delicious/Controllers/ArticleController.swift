//
//  ArticleController.swift
//  Delicious
//
//  Created by Sean Choo on 4/27/16.
//  Copyright © 2016 Demo. All rights reserved.
//

import UIKit

class ArticleController: UITableViewController {

    let screenWidth: CGFloat = UIScreen.main.bounds.width
    let screenHeight: CGFloat = UIScreen.main.bounds.height
    
    var currentArticle: Article?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 500.0
        
        initializeArticle()
    }
    
    func initializeArticle() {
        let mainContent = "Start your day with this amazing breakfast, and you will be happy throughout the day"
        let article = Article(title: "Lovely Breakfast", mainContent: mainContent, coverPhoto: "Toast", coverPhotoWidth: 1080, coverPhotoHeight: 810, mealType: "Breakfast", mealPrice: 34)
        article.restaurantName = "Toast Box"
        article.restaurantAddress = "G/F, JD Mall, 233-239 Nathan Rd, Jordan"
        article.restaurantLatitude = 22.304864882982680
        article.restaurantLongitude = 114.171386361122100
        article.authorDisplayName = "The Dreamer"
        article.authorUsername = "dreamer"
        
        let subContentOne = SubContent(photo: "Egg", photoWidth: 1080, photoHeight: 810, text: "Half-boiled eggs is a must")
        let subContentTwo = SubContent(photo: "Tea", photoWidth: 1080, photoHeight: 810, text: "Singapore/Malaysia-styled milk tea. Milder than Hong Kong style but still great")
        
        article.subContents = [subContentOne, subContentTwo]
        
        currentArticle = article
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let article = currentArticle {
            return 2 + article.subContents.count
        } else {
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            if let width = currentArticle?.coverPhotoWidth, let height = currentArticle?.coverPhotoHeight {
                return height/width * screenWidth
            }
        }
        return UITableViewAutomaticDimension
    }
    
    
    func attributedContentFromText(text: String) -> NSMutableAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineSpacing = 7
        let attrs = [NSFontAttributeName: UIFont.systemFont(ofSize: 15),
                     NSParagraphStyleAttributeName: paraStyle]
        let attrContent = NSMutableAttributedString(string: text, attributes: attrs)
        return attrContent
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cellForRow: UITableViewCell!
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoverPhotoCell", for: indexPath as IndexPath) as! CoverPhotoTableViewCell
            
            if let imageName = currentArticle?.coverPhoto {
                cell.coverImageView.image = UIImage(named: imageName)
            }
            
            cellForRow = cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MainContentCell", for: indexPath as IndexPath) as! MainContentTableViewCell
            cell.titleLabel.text = currentArticle?.title
            
            cell.contentLabel.textAlignment = .left
            if let text = currentArticle?.mainContent {
                cell.contentLabel.attributedText = attributedContentFromText(text: text)
            }
            
            cellForRow = cell
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SubContentCell", for: indexPath as IndexPath) as! SubContentTableViewCell
            
            if let article = currentArticle {
                let subContent = article.subContents[indexPath.row - 2]
                
                if let width = subContent.photoWidth, let height = subContent.photoHeight {
                    let heightRatio = height / width
                    cell.subImageViewHeight.constant = screenWidth * heightRatio
                }
                
                if let imageName = subContent.photo {
                    cell.subImageView.image = UIImage(named: imageName)
                }
                
                cell.subContentLabel.textAlignment = .left
                if let text = subContent.text {
                    cell.subContentLabel.attributedText = attributedContentFromText(text: text)
                }
                
            }
            
            cellForRow = cell
        }
        
        return cellForRow
    }
}

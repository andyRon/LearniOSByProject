//
//  SocialTableViewController.swift
//  SocialSharingDemo
//
//  Created by andyron on 2017/5/19.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit
import Social

class SocialTableViewController: UITableViewController {

    var restaurantNames = ["Cafe Deadend", "Homei", "Teakha", "Cafe Loisl", "Petite Oyster", "For Kee Restaurant", "Po's Atelier", "Bourke Street Bakery", "Haigh's Chocolate", "Palomino Espresso", "Upstate", "Traif", "Graham Avenue Meats", "Waffle & Wolf", "Five Leaves", "Cafe Lore", "Confessional", "Barrafina", "Donostia", "Royal Oak", "CASK Pub and Kitchen"]
    
    var restaurantImages = ["Cafe Deadend.jpg", "homei.jpg", "teakha.jpg", "Cafe Loisl.jpg", "petiteoyster.jpg", "For Kee Restaurant.jpg", "posatelier.jpg", "Bourke Street Bakery.jpg", "haighschocolate.jpg", "palominoespresso.jpg", "upstate.jpg", "traif.jpg", "grahamavenuemeats.jpg", "wafflewolf.jpg", "Five Leaves.jpg", "Cafe Lore.jpg", "Confessional.jpg", "Barrafina.jpg", "Donostia.jpg", "royaloak.jpg", "CASK Pub and Kitchen.jpg"]
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // Return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows
        return restaurantNames.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! SocialTableViewCell

        // Configure the cell...
        cell.featuredImageView.image = UIImage(named: restaurantImages[indexPath.row])
        cell.nameLabel.text = restaurantNames[indexPath.row]

        return cell
    }
    
    // MARK: - Action Methods
    
    @IBAction func share(_ sender: AnyObject) {
        
        // Get the selected row
        let buttonPosition = sender.convert(CGPoint.zero, to: tableView)
        guard let indexPath = tableView.indexPathForRow(at: buttonPosition) else {
            return
        }
        
        // Display the share menu
        let shareMenu = UIAlertController(title: nil, message: "Share using", preferredStyle: .actionSheet)
        let twitterAction = UIAlertAction(title: "Twitter", style: UIAlertActionStyle.default, handler: {
            (action) in
            guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeTwitter) else {
                let alertMessage = UIAlertController(title: "Twitter Unavailable", message: "You haven't registered your Twitter account. Please go to Settings > Twitter to create one", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                return
            }
            
            if let tweetComposer = SLComposeViewController(forServiceType: SLServiceTypeTwitter) {
                tweetComposer.setInitialText("Having lunch at " + self.restaurantNames[indexPath.row])
                tweetComposer.add(UIImage(named: self.restaurantImages[indexPath.row]))
                self.present(tweetComposer, animated: true, completion: nil)
            }
        })
        let facebookAction = UIAlertAction(title: "Facebook", style: UIAlertActionStyle.default, handler:{
            (action) in
            
            guard SLComposeViewController.isAvailable(forServiceType: SLServiceTypeFacebook) else {
                let alertMessage = UIAlertController(title: "Facebook Unavailable", message: "You haven't registered your Facebook account. Please go to Settings > Facebook to create one", preferredStyle: .alert)
                alertMessage.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertMessage, animated: true, completion: nil)
                return
            }
            
            if let fbComposer = SLComposeViewController(forServiceType: SLServiceTypeFacebook) {
                fbComposer.setInitialText("Having lunch at " + self.restaurantNames[indexPath.row])
                fbComposer.add(UIImage(named: self.restaurantImages[indexPath.row]))
                fbComposer.add(URL(string: "https://ww.appcoda.com"))
                self.present(fbComposer, animated: true, completion: nil)
            }
        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        shareMenu.addAction(twitterAction)
        shareMenu.addAction(facebookAction)
        shareMenu.addAction(cancelAction)
        
        self.present(shareMenu, animated: true, completion: nil)
        
    }
    

}

//
//  AlphabetViewController.swift
//  ReorderingCollectionViewTutorial
//
//  Created by andyron on 2017/3/29.
//  Copyright © 2017年 andyron. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AlphabetViewController: UICollectionViewController {
    
    var characterArray = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        
        for i in str.characters {
            characterArray.append(String(i))
        }
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return characterArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! AlphabetCell
    
        cell.alphabetLabel.text = characterArray[indexPath.row]
        
        return cell
    }


    // cell 长按拖动使两个cell互换位置后调用
    override func collectionView(_ collectionView: UICollectionView, moveItemAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp = characterArray[sourceIndexPath.row]
        characterArray[sourceIndexPath.row] = characterArray[destinationIndexPath.row]
        characterArray[destinationIndexPath.row] = temp
        
        print(sourceIndexPath)
        print(destinationIndexPath)
    }

}

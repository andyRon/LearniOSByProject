/// Copyright (c) 2019 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import UIKit
import ContactsUI

class FriendsViewController: UITableViewController {
  var friendsList = Friend.defaultContacts()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navigationItem.titleView = UIImageView(image: UIImage(named: "RWConnectTitle")!)
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.navigationBar.tintColor = .white
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
  }
  
  @IBAction private func addFriends(sender: UIBarButtonItem) {
    // 1
    let contactPicker = CNContactPickerViewController()
    contactPicker.delegate = self
    // 2
    contactPicker.predicateForEnablingContact = NSPredicate(
      format: "emailAddresses.@count > 0")
    present(contactPicker, animated: true, completion: nil)
  }
  
}

//MARK: - UITableViewDataSource
extension FriendsViewController {
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return friendsList.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath)
    
    if let cell = cell as? FriendCell {
      let friend = friendsList[indexPath.row]
      cell.friend = friend
    }
    
    return cell
  }
}

//MARK: - UITableViewDelegate
extension FriendsViewController {
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    // 1
    let friend = friendsList[indexPath.row]
    let contact = friend.contactValue
    // 2
    let contactViewController = CNContactViewController(forUnknownContact: contact)
    contactViewController.hidesBottomBarWhenPushed = true
    contactViewController.allowsEditing = false
    contactViewController.allowsActions = false
    // 3
    navigationController?.navigationBar.tintColor = .appBlue
    navigationController?.pushViewController(contactViewController, animated: true)
  }
}

//MARK: - CNContactPickerDelegate
extension FriendsViewController: CNContactPickerDelegate {
  func contactPicker(_ picker: CNContactPickerViewController,
                     didSelect contacts: [CNContact]) {
    let newFriends = contacts.compactMap { Friend(contact: $0) }
    for friend in newFriends {
      if !friendsList.contains(friend) {
        friendsList.append(friend)
      }
    }
    tableView.reloadData()
  }
}


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
import Contacts

class EditFriendTableViewController: UITableViewController {
  @IBOutlet private weak var nameLabel: UILabel!
  @IBOutlet private weak var emailLabel: UILabel!
  @IBOutlet private weak var phoneTypeLabel: UILabel!
  @IBOutlet private weak var phoneTextField: UITextField!
  @IBOutlet private weak var saveButton: UIButton!

  var friend: Friend?

  override func viewDidLoad() {
    super.viewDidLoad()
    setup()
  }

  private func setup() {
    guard let friend = friend else {
      nameLabel.text = ""
      emailLabel.text = ""
      phoneTextField.text = ""
      phoneTextField.isEnabled = false
      return
    }
    let formatter = CNContactFormatter()
    formatter.style = .fullName
    if let name = formatter.string(from: friend.contactValue) {
      nameLabel.text = name
    } else {
      nameLabel.text = "Name Not Available"
    }
    emailLabel.text = friend.workEmail
    if let phoneNumberField = friend.phoneNumberField,
      let label = phoneNumberField.label {
      phoneTypeLabel.text = CNLabeledValue<CNPhoneNumber>.localizedString(forLabel: label)
      phoneTextField.text = phoneNumberField.value.stringValue
    }
  }

  @IBAction private func save(_ sender: Any) {
    phoneTextField.resignFirstResponder()
  }
}
